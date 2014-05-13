require "awesome_print"
require "./command/CommandHandler"
require "./util/NetUtil"
require "./util/ByteUtil"
require "./common/ControlFile"
require "./common/DataFile"
require "./common/PrintJob"

class CommandRecvJob < CommandHandler

  def initialize comm, sock
    @comm = comm
    @sock = sock
  end

  def execute
    ap "CommandRecvJob : excute "
    command = ByteUtil.parseCommand @comm
    return nil if command.nil? || 1 > command.length

    cmd = command[0]
    ap "command passed in was bad!!!" unless( cmd == "\x02" )

    @sock.write("\x00")

    printJob = recvPrintJob

    # Queue ing ing ing ing
    ap "print job : #{printJob.to_s}"

    # output file
    save_print_job(printJob)

    ap 'End : CommandRecvJob : excute'
  end

  def recvPrintJob
    controlFile = nil
    dataFile = nil
    printJob = nil

    (0..1).each do
      subCommand = NetUtil.readNextInput @sock
      cmd = ByteUtil.parseCommand subCommand

      case subCommand[0]
      when "\x02"
        ap "set Control File"
        controlFile = setControlFile(cmd)
      when "\x03"
        ap "set Data File"
        dataFile = setDataFile(cmd)
      else
        ap "is that error? : sub command --> : " + subCommand[0]
      end
    end

    if( nil != controlFile && nil != dataFile )
      printJob = PrintJob.new(controlFile, dataFile)
    end

    printJob
  end

  def setControlFile cmd
    controlFile_Size = cmd[1]
    controlFile_Header = cmd[2]

    header_List = ByteUtil.parse_PinrtFile_Name controlFile_Header

    if header_List.size == 3
      cFile = NetUtil.read_controlFile @sock
      control_flie = ControlFile.new
      control_flie.size = controlFile_Size.to_s
      control_flie.jobNumber = header_List[1].to_s
      control_flie.hostName = header_List[2].to_s
      control_flie.contents = cFile

      ap "Control Flie's Size : #{control_flie.size}"
      ap "Control Flie's JobNumber : #{control_flie.jobNumber}"
      ap "Control Flie's HostName : #{control_flie.hostName}"
    else
      ap "Control File Header did not parse properly : #{controlFile_Header}"
    end

    control_flie
  end

  def setDataFile cmd
    dataFile_Size = cmd[1]
    dataFile_Header = cmd[2]

    header_List = ByteUtil.parse_PinrtFile_Name dataFile_Header
    if header_List.size == 3
      df_Size = dataFile_Size.to_i
      ap "Data File's Command : #{cmd}"
      ap "Data File's Size : #{df_Size}"

      if 0 == df_Size || 125899906843000 == df_Size
        df_Size = 0
      end

      dFile = NetUtil.read_PrintFile @sock, df_Size

      data_file = DataFile.new
      data_file.size = dataFile_Size.to_s
      data_file.jobNumber = header_List[1].to_s
      data_file.hostName = header_List[2].to_s
      data_file.contents = dFile
      data_file
    end
  end

  def save_print_job(printJob)
    begin
      file_path = ENV['OUTPUT_DIR'] + printJob.dataFile.jobNumber + "\\" + printJob.dataFile.hostName + "\\" + Time.now.to_i.to_s + '.prn'
      ap 'save print file path : ' + file_path
      file = File.open(file_path, "rw+")
      file.write(printJob.dataFile.contents)
    rescue IOError => e
      ap 'IO Error...save_print_job'
      ap e
    ensure
      file.close unless file == nil
    end
  end

end
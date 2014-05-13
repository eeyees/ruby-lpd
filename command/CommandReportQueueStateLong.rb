require 'awesome_print'
require './command/CommandHandler'
require './util/ByteUtil'

class CommandReportQueueStateLong < CommandHandler
  
  def initialize comm, sock
    @comm = comm
    @sock = sock
  end

  def execute
    ap "CommandReportQueueStateLong : excute "

    command = ByteUtil.parseCommand comm
    return nil if nil == command || 1 > command.length

    cmd = command[0]
    queue = command[1]

    queueState << "Job Id  "
    queueState << "Name                "
    queueState << "Owner          "
    queueState << "Date                "
    queueState << "Size     "
    queueState << "\n"

    # and Get queue info --> get LongDescription
    queueState << "blah blah blah"
    queueState << "\n"

    unless ("\x04" == cmd[0])
      p "cmd[0]=" + cmd[0] + ", should of been 0x4"
      return nil
    end

    @sock.write(queueState)

    ap 'End : CommandReportQueueStateLong : excute'
  end
end
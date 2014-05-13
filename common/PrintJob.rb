require "./common/ControlFile"
require "./common/DataFile"

class PrintJob
  attr_accessor :controlFile
  attr_accessor :dataFile

  @JOB_ID_LENGTH = 8;
  @JOB_NAME_LENGTH = 20;
  @JOB_OWNER_LENGTH = 15;
  @JOB_DATE_LENGTH = 20;
  @JOB_SIZE_LENGTH = 9;

  def initialize(controlFile, dataFile)
    @controlFile = controlFile
    @dataFile = dataFile
  end

  def Name
    return @controlFile.ControlFileCommands.JobName
  end

  def Size
    return @dataFile.Contents.Length
  end

  def Owner
    return @controlFile.ControlFileCommands.UserId
  end

  def ControlFile
    return @controlFile
  end

  def DataFile
    return @datafile
  end
end

# SaveToFileHandler
require "awesome_print"

class SaveToFileHandler < HandlerInterface
  attr_accessor :outputDirectory
  attr_accessor :extension

  def initialize
  end

  def process printJob
    return false if printJob.nil? || printJob.dataFile.nil? || printJob.controlFile.nil? 

    ret = false
    if outputDirectory.nil || outputDirectory == ""
      fileName = printJob.Name + printJob.ControlFile.JobNumber + ".txt";
    else
      fileName = outputDirectory + printJob.ControlFile.JobNumber + extension;
    end

    ret
  end
end
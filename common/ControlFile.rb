require "./common/PrintFile"
require "./common/ControlFileCommands"

class ControlFile < PrintFile
  attr_accessor :controlFileCommands

  def initialize
  end

  def setControlFileCommands command
    @controlFileCommands = ControlFileCommands.new(command)
  end
  
end
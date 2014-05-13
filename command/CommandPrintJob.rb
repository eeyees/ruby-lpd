require "awesome_print"
require "./command/CommandHandler"
require './util/ByteUtil'

class CommandPrintJob < CommandHandler

  def initialize comm, sock
    @comm = comm
    @sock = sock
  end

  def execute
    ap "CommandPrintJob : excute "
    
    command = ByteUtil.parseCommand @comm
    return nil if nil == command || 1 > command.length
    return nil unless "\x01" == command[0]

    ap "End : CommandPrintJob : excute "
end
require 'awesome_print'
require 'socket'
require './command/CommandHandler'
require './command/CommandRecvJob'
require './util/ByteUtil'

class LPDCommand

  def handleCommand comm, sock
    commandHandler = createCommandHandler comm, sock
    return nil if nil == commandHandler

    commandHandler.execute
  end

  def createCommandHandler comm, sock
    commands = ByteUtil.parseCommand comm

    if nil != commands && commands.length > 0
      cmd = commands[0]
      
      ret = case cmd[0]
      when "\x01"
        ap "Print Job Command"
        cHandler = CommandPrintJob.new comm, sock
      when "\x02"
        ap "Receive Job Command"
        cHandler = CommandRecvJob.new comm, sock
      when "\x03"
        ap "Short Command"
        cHandler = CommandReportQueueStateShort.new comm, sock
      when "\x04"
        ap "Long Command"
        cHandler = CommandReportQueueStateLong.new comm, sock
      when "\x05"
        ap "Remove Print Job Command"
        cHandler = CommandRemovePrintJob.new comm, sock
      else
        ap "Can Not Found Command : " + cmd[0]
      end
    end

    cHandler
  end
end
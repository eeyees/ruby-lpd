require 'awesome_print'
require './command/CommandHandler'
require './util/ByteUtil'

class CommandReportQueueStateShort < CommandHandler
  
  def initialize comm, sock
    @comm = comm
    @sock = sock
  end

  def execute
    ap "CommandReportQueueStateShort : excute "

    command = ByteUtil.parseCommand comm
    return nil if nil == command || 1 > command.length

    cmd = command[0]
    queue = command[1]

    queueState << "Job Id  "
    queueState << "Name                "
    queueState << "Owner          "
    queueState << "\n"

    # and Get queue info --> get ShortDescription
    queueState << "blah blah blah"
    queueState << "\n"

    unless ("\x03" == cmd[0])
      p "cmd[0]=" + cmd[0] + ", should of been 0x3"
      return nil
    end

    @sock.write(queueState)

    ap 'End : CommandReportQueueStateShort : excute'
  end
end
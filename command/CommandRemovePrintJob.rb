require 'awesome_print'
require './command/CommandHandler'
require './util/ByteUtil'

class CommandRemovePrintJob < CommandHandler

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
    user = command[2]
    jobNumber = ""

    queueName = queue.strip
    userName = user.strip
    jobId = ""

    if 2 > command.length
      jobNumber = command[3]
      jobId = ByteUtil.parse jobNumber
    else
      # search queue by queueName

      # search queue info

      # get Job ID by queue Info
      jobId = ""
    end

    unless ("\x05" == cmd[0])
      p "cmd[0]=" + cmd[0] + ", should of been 0x5"
      return nil
    end

    # Remove Print Job  --> Print Queue

  end
end
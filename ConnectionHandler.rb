require 'socket'
require 'awesome_print'
require './util/NetUtil'
require './command/LPDCommand' 

class ConnectionHandler

  def initialize sock
    @sock = sock
  end

  def run()
    bytes = NetUtil.readCommand @sock
    LPDCommand.new.handleCommand bytes, @sock
  end
end

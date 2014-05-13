require 'dotenv'
require 'thread'
require 'socket'
require './ConnectionHandler'
require './util/NetUtil'

class LPR
  Dotenv.load
  @serverSock = TCPServer.new(ENV['SERV_IP'], ENV['SERV_PORT'])
  @threads = []
  @socks = []

  begin
    @threads << Thread.new {
      clientSock = @serverSock.accept
      p "#{clientSock} is conncted"

      ConnectionHandler.new(clientSock).run()

      clientSock.close
      p "#{clientSock} is closed"
    }

    # wait thread....
    @threads.each{ |aThread| aThread.join }

    p "#{@serverSock} is close"
  end while true
  
  @serverSock.close
end
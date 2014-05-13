require 'awesome_print'
require 'socket'

module NetUtil
  # @GOOD_ACK = "\x00"
  # @BAD_ACK = "\x01"

  def self.readCommand sock
    return nil if sock.eof?

    bytes = ""
    begin
      data = sock.read(1)
      bytes << data
    end while (-1 != data && "\n" != data)

    bytes << data unless( -1 == data )

    return bytes
  end

  def self.readNextInput sock
    return nil if sock.eof?

    bytes = readCommand sock
    sock.write("\x00")
    bytes
  end

  def self.read_controlFile sock
    return nil if sock.eof?

    ap 'read_controlFile'
    if nil == sock
      return nil
    end

    bytes = ""

    begin
      data = sock.read(1)
      bytes << data
    end while(-1 != data && "\x00" != data)

    sock.write("\x00")
    bytes
  end

  def self.read_PrintFile sock, size
    return nil if sock.eof?
    
    ap 'read_PrintFile'
    bytes = ""
    
    if 0 == size
      begin
        data = sock.read(1)
        bytes << data unless( nil == data )
      end while(-1 != data && "\x00" != data)      
    else
      count = 1
      begin
        data = sock.read(1)
        bytes << data unless( nil == data )
        count += 1
      end while(-1 != data && size >= count)
    end
    
    sock.write("\x00")
    bytes
  end
end
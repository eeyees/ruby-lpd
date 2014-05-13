require './util/ByteUtil'

class ControlFileCommands
  attr_accessor :classForBannerPage
  attr_accessor :host
  attr_accessor :indentCount
  attr_accessor :jobName
  attr_accessor :userName
  attr_accessor :email
  attr_accessor :fileName
  attr_accessor :userId
  attr_accessor :symbolicLinkData
  attr_accessor :title
  attr_accessor :fileToUnlink
  attr_accessor :widthCount
  attr_accessor :troffRFontFileName
  attr_accessor :troffIFontName
  attr_accessor :troffBFontName
  attr_accessor :troffSFontName
  attr_accessor :plotCIFFileName
  attr_accessor :printDVIFileName
  attr_accessor :fileToPrintAsText
  attr_accessor :fileToPlot
  attr_accessor :fileToPrintAsTextRaw
  attr_accessor :fileToPrintAsDitroff
  attr_accessor :fileToPrintAsPostscript
  attr_accessor :fileToPrintAsPr
  attr_accessor :fileToPrintFortran
  attr_accessor :fileToPrintAsTroff
  attr_accessor :fileToPrintAsRaster

  def initialize bytes
    buff = ""
    for byte in bytes
      if byte != "\n"
        buff << byte
      else
        buff << byte
        processCommand buff
        buff = []
      end
    end
  end

  def processCommand command
    bytes = ByteUtil.parseCommand command
    cmdCode = ByteUtil.parse bytes[0]

    if bytes.length > 2
      for byte in bytes
        str = ByteUtil.parse byte
        str = str + " "
      end

      operand = str.strip
    else
      operand = ByteUtil.parse bytes[1]
    end

    setAttribute cmdCode, operand
  end

  def setAttribute cmdCode, operand
    case cmdCode
    when "C"
        @classForBannerPage = operand
    when "H"
      @host = operand
    when "I"
      @indentCount = operand
    when "J"
      @jobName = operand
    when "L"
      @userName = operand
    when "M"
      @email = operand
    when "N"
      @fileName = operand
    when "P"
      @userId = operand
    when "S"
      @symbolicLinkData = operand
    when "T"
      @title = operand
    when "U"
      @fileToUnlink = operand
    when "W"
      @widthCount = operand
    when "1"
      @troffRFontFileName = operand
    when "2"
      @troffIFontName = operand
    when "3"
      @troffBFontName = operand
    when "4"
      @troffSFontName = operand
    when "c"
      @plotCIFFileName = operand
    when "d"
      @printDVIFileName = operand
    when "f"
      @fileToPrintAsText = operand
    when "g"
      @fileToPlot = operand
    when "l"
      @fileToPrintAsTextRaw = operand
    when "n"
      @fileToPrintAsDitroff = operand
    when "o"
      @fileToPrintAsPostscript = operand
    when "p"
      @fileToPrintAsPr = operand
    when "r"
      @fileToPrintFortran = operand
    when "t"
      @fileToPrintAsTroff = operand
    when "v"
      @fileToPrintAsRaster = operand
    else
      "not found attrubute code : #{cmdCode}"
    end

    ap 'setAttribute end'
  end

end
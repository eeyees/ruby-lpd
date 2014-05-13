module ByteUtil
  def self.parseCommand command
    ret = command[1..-1].gsub("\n", " ").split(" ").map(&:strip).reject(&:empty?).unshift(command[0])
  end

  def self.parse data
    data.gsub(/(.)/, '\1' + ' ')
  end

  def self.parse_PinrtFile_Name data
    ret = data.scan(/(...)(...)(.+)/)[0]
  end
end
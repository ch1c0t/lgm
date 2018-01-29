class Link
  def initialize string
    @string = string
  end
  
  def valid?
    ['http://', 'https://'].any? { |prefix| @string.start_with? prefix } &&
      @string.include?(?.)
  end

  def to_json _state = nil # JSON::Ext::Generator::State
    @string.to_json
  end
end

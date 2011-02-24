require_relative 'option'

class OptionQuote

  attr_reader :option, :bid, :ask

  def initialize(option, args)
    @option = option
    @bid = args[:bid] || nil
    @ask = args[:ask] || nil
  end
  
  def spread
    if @bid and @ask
      (@ask - @bid).prettify.to_f
    else
      nil
    end
  end

  def to_s
    "#{option.to_s}: #{bid.inspect} / #{ask.inspect}"
  end

  def inspect
    "#{option.inspect}: bid => #{bid.inspect}, ask => #{ask.inspect}"
  end

end

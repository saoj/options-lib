require_relative 'option'

class OptionQuote

  attr_reader :option, :bid, :ask, :stock_price

  def initialize(option, args)
    @option = option
    @bid = args[:bid] || nil
    @ask = args[:ask] || nil
    @stock_price = args[:stock_price] || nil
  end
  
  def spread
    if @bid and @ask
      (@ask - @bid).prettify.to_f
    else
      nil
    end
  end

  def to_s
     "#{option}: bid => #{bid}, ask => #{ask}"
  end

end

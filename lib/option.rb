require 'date'
require_relative 'helpers'

class Option

  CALL = 'CALL'
  PUT = 'PUT'

  attr_reader :stock, :exp, :type, :strike, :symbol, :internal_symbol
  
  def initialize(type, stock, strike, exp, symbol = nil)
    raise "Invalid type: #{type}" if type != CALL and type != PUT

    @type, @stock, @strike = type, stock, strike.to_f

    if exp =~ /(\d{4})[\-\/](\d{1,2})[\-\/](\d{1,2})/
      @exp = Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise "Cannot parse expiration date: #{exp}"
    end
    
    s = "#{stock}_#{type == CALL ? 'C' : 'P'}#{@strike.prettify}_#{@exp.day}"
    s << "-#{Date::MONTHNAMES[@exp.month][0,3].upcase}"
    s << "-#{@exp.year.to_s}"
    @internal_symbol = s

    if not symbol
      @symbol = @internal_symbol
    else
      @symbol = symbol
    end
  end

  def is_call?
    @type == CALL
  end

  def is_put?
    @type == PUT
  end

  # Business days (= minus Sat and Sun) until expiration
  def days_to_exp
    total = 0
    curr_day = Date.today
    while curr_day <= exp
      total += 1 if curr_day.wday != 0 and curr_day.wday != 6
      curr_day = curr_day.next
    end
    total
  end

  def to_s
    @internal_symbol
  end

  def inspect
    @internal_symbol
  end
end



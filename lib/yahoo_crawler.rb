require 'thread'
require 'Mechanize'

require_relative 'option'
require_relative 'option_quote'
require_relative 'helpers'

# A Yahoo!Finance crawler implemented using Mechanize to parse HTML and extract
# options quotes for given stock and expiration date.
class YahooCrawler

  def initialize(stock, exp)
    @mech = Mechanize.new
    @stock, @exp = stock, exp
    @url = "http://finance.yahoo.com/q/op?s=#{stock}&m=#{exp[0,7]}"
    @stock_curr_price = nil
    @call_options = Hash.new
    @put_options = Hash.new
    @call_strikes = Array.new
    @put_strikes = Array.new
    @lock = Mutex.new
    @t_lock = Mutex.new
    @thread = nil
  end

  def auto_reload(period = 60)
    if not @thread.nil?
      stop
    end

    @thread = Thread.new do
      loop do
        begin
          fetch
        rescue => e
          puts "Error fetching data: #{e.message}"
        end
        sleep period
      end
    end

  end

  def stop
    if not @thread.nil?
      @thread.kill
      @thread = nil
    end
  end

  def fetch

    c_options, p_options = Hash.new, Hash.new
    c_strikes, p_strikes = Array.new, Array.new
    stock_price = nil

    @t_lock.synchronize { # don't step into each other in case someone calls fetch

      page = @mech.get(@url).body

      curr_price = page.scan(/\: \<.+?\<\/big\>/)
      lines = parse_data(curr_price[0])
      stock_price = lines[0].to_f
      
      calls = page.scan(/Strike\<.+Put Options/)
      puts = page.scan(/Put Options\<.+Highlighted/)

      lines = parse_data(calls[0])
      lines = lines.chunk(lines.length / 8)

      lines.each do |array|
        quote = parse_quote(array, Option::CALL)
        c_options[quote.option.strike] = quote
      end

      lines = parse_data(puts[0])
      lines = lines.chunk(lines.length / 8)

      lines.each do |array|
        quote = parse_quote(array, Option::PUT)
        p_options[quote.option.strike] = quote
      end

      c_options.keys.sort.each { |key| c_strikes << key }

      p_options.keys.sort.each { |key| p_strikes << key }

    }

    @lock.synchronize {
      @call_options, @put_options = c_options, p_options
      @call_strikes, @put_strikes = c_strikes, p_strikes
      @curr_stock_price = stock_price
    }
    
  end

  def get_option_quote(type, strike)
    if type == Option::CALL
      get_call_option_quote(strike)
    else
      get_put_option_quote(strike)  
    end
  end

  def get_call_option_quote(strike)
    call_options[strike]    
  end

  def get_put_option_quote(strike)
    put_options[strike]
  end

  def call_strikes
    @lock.synchronize { @call_strikes }
  end

  def put_strikes
    @lock.synchronize { @put_strikes }
  end

  def call_options
    @lock.synchronize { @call_options }
  end

  def put_options
    @lock.synchronize { @put_options }
  end

  def curr_stock_price
    @lock.synchronize { @curr_stock_price }
  end

  def show_calls
    call_strikes.each { |key| puts call_options[key] }
  end

  def show_puts
    put_strikes.each { |key| puts put_options[key] }
  end

  private

  def parse_quote(line, type)
    strike = line[0].to_f
    symbol = line[1]
    bid = f line[4]
    ask = f line[5]

    o = Option.new(type, @stock, strike, @exp, symbol)
    OptionQuote.new(o, :bid => bid, :ask => ask)
  end

  # Get all values inside tags
  # Ex: <h1>234</h1> will return "234"
  def parse_data(data)
    data.scan(/\>[0-9\.A-Z\,\/]+\</).collect { |i| i.gsub(/[\<\>]/, "") }
  end

  def f(data)
    data == 'N/A' ? nil : data.to_f
  end

end

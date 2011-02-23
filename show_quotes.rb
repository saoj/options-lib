# require all files from lib
Dir["./lib/*.rb"].each {|file| require file }

if ARGV.length != 5
  puts "format: ruby show_quotes.rb <stock> <call_or_put> <strike> <expiration> <reload_period>"
  puts "example: ruby show_quotes.rb AAPL C 345 2013-01-18 5"
  exit
end

stock = ARGV[0]
is_call = ARGV[1].casecmp("C") == 0
strike = ARGV[2].to_f
expiration = ARGV[3]
reload_period = ARGV[4].to_i

y = YahooCrawler.new(stock, expiration)

y.auto_reload(reload_period) do
  
  options = is_call ? y.call_options : y.put_options
  quote = options[strike]
  stock_price = y.curr_stock_price
  
  puts "Stock @ #{stock_price} Options: #{quote.bid} | #{quote.ask}"
  
end

y.join_reload_thread


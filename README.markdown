# Options-Lib

A set of classes for dealing with options. It includes a crawler for Yahoo!Finance. The crawler has an internal
thread that can be started to periodically update the option quotes.

## Install

	gem install options-lib
	
## Usage

	require 'options-lib'
	
	# Create a crawler for all the options for ('AAPL') expiring on '2013-01-18'
	y = YahooCrawler.new('AAPL', '2013-01-18')
	
	# Fetch the entire options chain for this stock and expiration
	y.fetch
	
	# Show an option quote for a given strike price
	y.call_options[300] # => AAPL_C300_18JAN2013: bid => 88.5, ask => 90.5
	y.put_options[300] # => AAPL_P300_18JAN2013: bid => 40.7, ask => 41.95
	
	# Options quote has stock price, bid and ask for option
	q = y.call_options[300]
	q.stock_price # => 342.88
	q.bid # => 88.5
	q.ask # => 90.5
	
	# Crawler also has current stock price, as each option quote
	y.stock_price # => 342.88
	
	# You can get a list of all stock prices from the crawler
	y.call_strikes # => [135.0, 140.0, ..., 530.0, 540.0]
	y.put_strikes # => [135.0, 140.0, ..., 530.0, 540.0]
	
	# So to print the entire options chain, you can do something like that
	y.call_strikes.each { |strike| puts y.call_options[strike] }
	y.put_strikes.each { |strike| puts y.put_options[strike] }	

	# you can place the crawler in auto_reload mode, passing a period to refresh itself
	y.auto_reload 5
	y.call_options[300].bid # => 88.5
	sleep 6
	y.call_options[300].bid # => 90.3
	
	# you can also receive callbacks from the internal thread when the crawler gets updated
	y.auto_reload(5) do
	  puts "Current bid: #{y.call_options[300].bid}"
	end
	
	# if you need to block ruby from exiting while your thread is executing in the background
	# you can use the method below
	y.join_reload_thread
	
	# internal symbol versus real symbol
	y.internal_symbol # => AAPL_C300_18JAN2013
	y.symbol # => AAPL130119C00300000

## Executable

It comes with the 'show_quotes' executable.

	[soliveira@sergio-macos options-lib]$ show_quotes
	format: show_quotes <stock> <call_or_put> <strike> <expiration> <reload_period>
	example: show_quotes AAPL C 345 2013-01-18 5
	[soliveira@sergio-macos options-lib]$ show_quotes AAPL C 345 2013-01-18 5
	Stock @ 342.88 Options: 65.9 | 67.8 Spread: 1.9
	Stock @ 342.88 Options: 65.9 | 67.8 Spread: 1.9

	
	
	
	


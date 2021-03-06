# Options-Lib

<b>Note:</b> This lib is currently not working with Yahoo!Finance. It was done 6 years ago and needs to be udpated to parse the latest Yahoo!Finance quote layout. I plan to migrate this code to Scala in a near future.

A set of classes for dealing with options. It includes a crawler for Yahoo!Finance. The crawler has an internal
thread that can be started to periodically update the option quotes.

<!-- ## Donate

If this project has helped you make money in the stock market, please consider donating. This will help me justify to my family and friends why I spend so much time in front of a computer. Thanks!

<div style="padding:2px; border:1px solid silver; float:right; margin:0 0 1em 2em; background:white">
	<a href='http://www.pledgie.com/campaigns/14723' target="_blank"><img src='http://pledgie.com/campaigns/14723.png?skin_name=chrome' border='0' alt="Click here to lend your support to: Sergio's Open Source projects and make a donation at www.pledgie.com !" /></a> 
</div>
-->
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
	
	# internal symbol versus real symbol
	q.option.internal_symbol # => AAPL_C300_18JAN2013
	q.option.symbol # => AAPL130119C00300000
	
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
	
## Executable

It comes with the 'show_quotes' executable.

	[soliveira@sergio-macos options-lib]$ show_quotes
	format: show_quotes <stock> <call_or_put> <strike> <expiration> <reload_period>
	example: show_quotes AAPL C 345 2013-01-18 5
	[soliveira@sergio-macos options-lib]$ show_quotes AAPL C 345 2013-01-18 5
	Stock @ 342.88 Options: 65.9 | 67.8 Spread: 1.9
	Stock @ 342.88 Options: 65.9 | 67.8 Spread: 1.9

	
	
	
	


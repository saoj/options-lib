# require all files from lib
Dir["./lib/*.rb"].each {|file| require file }

describe YahooCrawler do
  
  y = nil
  
  before(:all) do
    y = YahooCrawler.new('AAPL', '2013-01-18')
    y.fetch
  end
    
  it 'should be able to fetch options quotes from Yahoo!Finance' do
    
    y.call_options.length.should > 0
    y.put_options.length.should > 0
    
  end
  
  it 'should be able to get current price of stock' do
    
    y.curr_stock_price.should > 0
    
  end
  
  it 'should be able to return an array of strike prices' do
    
    y.call_strikes.length.should > 0
    y.put_strikes.length.should > 0
    
  end
  
  it 'should be able to give an option quote by strike price' do
    
    # get a good strike price by rounding the current stock price
    good_price = ((y.curr_stock_price / 100).to_i * 100).to_f
  
    call_quote = y.call_options[good_price]
    call_quote.option.internal_symbol.should == "AAPL_C#{good_price.to_i}_18JAN2013"
    call_quote.bid.should > 0
    call_quote.ask.should > 0
    
    put_quote = y.put_options[good_price]
    put_quote.option.internal_symbol.should == "AAPL_P#{good_price.to_i}_18JAN2013"
    put_quote.bid.should > 0
    put_quote.ask.should > 0
    
  end
  
  it 'should be able to update the quotes in a background thread' do
  
    y.auto_reload(1)
    y.call_options.length.should > 0
    y.put_options.length.should > 0
    
  end

    
end
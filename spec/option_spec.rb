# require all files from lib
Dir["./lib/*.rb"].each {|file| require file }

describe Option do

  it 'can be a call or a put' do
    o = Option.new(Option::CALL, 'AAPL', 250, '2010-02-14')
    o.type.should == Option::CALL
    o.type.should == 'CALL'

    o = Option.new(Option::PUT, 'AAPL', 250, '2010-02-14')
    o.type.should == Option::PUT
    o.type.should == 'PUT'
  end
  
  it 'has stock and strike price' do
    o = Option.new(Option::CALL, 'AAPL', 250, '2010-02-14')
    o.stock.should == 'AAPL'
    o.strike.should == 250

  end

  it 'converts expiration to a nice date object' do
    o = Option.new(Option::PUT, 'AAPL', 250, '2010-08-14')
    o.exp.day.should == 14
    o.exp.month.should == 8
    o.exp.year.should == 2010

    o = Option.new(Option::CALL, 'AAPL', 250, '2011/09/15')
    o.exp.day.should == 15
    o.exp.month.should == 9
    o.exp.year.should == 2011
  end
  
  it 'throws an exception if date is bad' do
    lambda {Option.new(Option::PUT, 'AAPL', 250, '10-08-14')}.should raise_error
    lambda {Option.new(Option::PUT, 'AAPL', 250, '10-58-14')}.should raise_error
    lambda {Option.new(Option::PUT, 'AAPL', 250, '2010-122-14')}.should raise_error
  end
  
  it 'has an internal symbol representation implied from stock, strike and experiration' do
    o = Option.new(Option::PUT, 'AAPL', 250, '2010-08-14')
    o.internal_symbol.should == 'AAPL_P250_14AUG2010'
  end
  
  it 'makes the symbol equals to the internal symbol if symbol not provided' do
    o = Option.new(Option::PUT, 'AAPL', 250, '2010-08-14')
    o.internal_symbol.should == o.symbol
  end
  
  it 'can have a symbol' do
    o = Option.new(Option::PUT, 'AAPL', 250, '2010-08-14', 'MYSYMBOL')
    o.symbol.should == 'MYSYMBOL'
    o.internal_symbol.should == 'AAPL_P250_14AUG2010'
  end

  it 'can show to number of business day until expiration' do
    d = Date.today + 10
    o = Option.new(Option::PUT, 'AAPL', 250, d.to_s)
    o.days_to_exp.should < 10
  end

end

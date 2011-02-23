# require all files from lib
Dir["./lib/*.rb"].each {|file| require file }

describe OptionQuote do
  
  it 'has option, bid and ask prices' do
    
    o = Option.new(Option::CALL, 'AAPL', 250, '2010-02-14')
    q = OptionQuote.new(o, :bid => 1.2, :ask => 1.4)
    q.option.should == o
    q.bid.should == 1.2
    q.ask.should == 1.4
    
  end
  
  it 'should have an spread' do
    o = Option.new(Option::CALL, 'AAPL', 250, '2010-02-14')
    q = OptionQuote.new(o, :bid => 1.2, :ask => 1.4)
    q.spread.prettify.should == "0.2"
    
  end
  
end
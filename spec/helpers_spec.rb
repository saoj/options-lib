# require all files from lib
Dir["./lib/*.rb"].each {|file| require file }

describe Float do
  
  it 'can format its value in a pretty way' do
    
    # if it has a decimal part, print it
    f = 50.1
    f.prettify.should == "50.1"
    
    # if decimal part is 0, do not print it
    f = 50.0
    f.prettify.should == "50"
  end
end

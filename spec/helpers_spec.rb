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

describe Array do

  it 'can be broken into chunks of smaller arrays' do
    
    # the first chunk is always the bigger in case the number of 
    # elements are not divisible by pieces
    
    a = [1,2,3,4]
    a.chunk.should == [[1,2],[3,4]]
    a.chunk(3).should == [[1,2],[3],[4]]
    a.chunk(4).should == [[1],[2],[3],[4]]
    
    a << 5 << 6
    a.chunk.should == [[1,2,3],[4,5,6]]
    a.chunk(3).should == [[1,2],[3,4],[5,6]]
    
    a << 7
    a.chunk.should == [[1,2,3,4],[5,6,7]]
    a.chunk(3).should == [[1,2,3],[4,5],[6,7]]
    
  end
  
end


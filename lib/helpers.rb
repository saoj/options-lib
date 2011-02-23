class Float
  
  # Supress decimal part if it is zero
  # 40.0 becomes "40"
  def prettify
    to_i == self ? to_i.to_s : self.to_s
  end
end

class Array

  # Break the array into smaller arrays (chuncks)
  # If the lenght of the array is not divisible by the number of chunks (pieces)
  # then first chunk will accomodate the extra item and be the larger chunk
  # Ex: [1,2,3,4].chunck # => [[1,2], [3,4]]
  def chunk(pieces=2)
    len = self.length;
    mid = (len / pieces)
    chunks = []
    start = 0
    1.upto(pieces) do |i|
      last = start + mid
      last = last - 1 unless len % pieces >= i
      chunks << self[start..last] || []
      start = last + 1
    end
    chunks
  end
end

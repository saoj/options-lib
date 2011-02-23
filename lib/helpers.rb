class Float
  
  # Supress decimal part if it is zero
  # 40.0 becomes "40"
  def prettify
    to_i == self ? to_i.to_s : self.to_s
  end
end

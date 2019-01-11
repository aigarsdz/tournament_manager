class Division
  A = 1
  B = 2

  def self.values
    self.constants.collect { |constant| self.const_get constant }
  end
end
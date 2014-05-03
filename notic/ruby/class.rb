class String
  def to_alphanumeric
    gsub /[^\w\s]/,''
  end
end

p '3 the dfdfd sdfsf'.to_alphanumeric
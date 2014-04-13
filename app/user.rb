class User

  PROPERTIES = [:id, :name, :email]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

end

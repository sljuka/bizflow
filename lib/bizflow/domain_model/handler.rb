class Bizflow::Handler

  attr_accessor :namespace, :name, :description

  def initialize(namespace, name, description = nil)
    @namespace = namespace
    @name = name
    @description = description
  end

  def full_name
    "#{namespace}:#{name}"
  end

end
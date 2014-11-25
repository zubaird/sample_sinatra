class Tasks

  attr_accessor :name, :completed

  def initialize(name, completed = false)
    @name = name
    @completed = completed
  end

end

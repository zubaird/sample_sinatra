class Project

  attr_accessor :name, :tasks

  def initialize(name, tasks = ["no tasks yet"])
    @name = name
    @tasks = tasks
  end

  def each
    tasks
  end

  def keys
    [name]
  end
end

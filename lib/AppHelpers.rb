module AppHelpers

  def redirect_hack(params)
    @params = params
  end
  # => Model helpers

  def add_task(project_name, task)
    @projects.each do |project|
      if project.name  == project_name
        # project.tasks << task
        @projects[@projects.index(project)].tasks << task
        # => need to write a test for this
        # => need to delete/update/save
      end
    end
  end

  def project_rename(old_name, new_name)
    get_old_project = @projects.detect { |project| project.name  == old_name }
    get_old_project.name = new_name
  end

  def project_add(name, *tasks )
    @projects << Project.new(name)
    write_file(@projects)
  end

  def project_delete(name)
    @projects.each.with_index do |listing, index|
      listing.each do |key, value|
        if key == name
          @projects.delete_at(index)
        end
      end
    end
  end

  def project_present?(name)
    @projects.each.with_index do |listing, index|
      if @projects[index][name.to_sym].exists?
        true
      else
        false
      end
    end
  end


  def file_read
    @projects = []
    if File.exist?('projects.yml')
      data = YAML.load_file('projects.yml')
      if data != false
        return data
      else
        @projects
      end
    end
  end

  def write_file(projects)
    File.open('projects.yml', 'w') do |f|
      f.write(make_yaml(projects))
    end
  end

  # => YAML HELPERS FOR EASIER USE :)
  def load_yaml(project)
    YAML.load(project)
  end

  def make_yaml(project)
    YAML.dump(project)
  end

  # => View helpers
  def print_projects_list
    @projects.delete_if { |x| x == ""}
  end

  def print_tasks_list(tasks)
    @tasks
  end

  def print_task_menu(project_name)
    task_options = ["Editing Project: #{project_name} ",
      "'list' to list tasks",
      "'create' to create a new task",
      "'edit' to edit a task",
      "'complete' to complete a task and remove it from the list",
    ]
  end

  def print_project_menu
    menu_options = [
      "'menu' to go to main menu",
      "'list' to list projects",
      "'new' to add a new project",
      "'remove' to remove a project",
      "'update' to update a project",
      "'edit' to edit a project",
    ]
  end

  def print_menu_links
    menu_links = [
      "menu",
      "list",
      "new",
      "remove",
      "update",
      "edit",
    ]
  end

end

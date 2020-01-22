class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end

end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(other)
    # below doesn't handle the exception
    # raise TypeError, 'Can only add Todo objects' unless other.instance_of? Todo
    # todos << other

    # begin
      raise TypeError, 'Can only add Todo objects' unless other.instance_of? Todo
      todos << other
    # rescue TypeError => e
    #   puts e.message
    # end
    # self
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a # does this need to be a shallow or deep copy?
    # Array.new(todos)
    todos.clone
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    # begin
      todos.fetch(index)
    # rescue IndexError => e
    #   puts e.class
    # end
  end

  def mark_done_at(index)
    # begin
      todos.fetch(index).done!
    # rescue IndexError => e
    #   puts e.class
    # end
  end

  def mark_undone_at(index)
    # begin
      todos.fetch(index).undone!
    # rescue IndexError => e
    #   puts e.class
    # end
  end

  def remove_at(index)
    # begin
      todos.delete_at(index) if todos.fetch(index)
    # rescue IndexError => e
    #   puts e.class
    # end
  end

  def done!
    todos.each do |todo|
      todo.done! unless todo.done?
    end
  end

  alias_method :mark_all_done, :done!

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def to_s
    output = ''
    output += "#{title}\n"
    todos.each { |todo| output += "#{todo.to_s}\n" }
    output.chomp
  end

  def each
    todos.each do |todo|
      yield(todo)
    end
    self
  end 

  def select
    list = TodoList.new(title)
    each do |todo|
      list << todo if yield(todo)
    end
    list
  end

  def find_by_title(string)
    # result = nil
    # each do |todo|
    #   if todo.title == string
    #     result = todo
    #     break
    #   end
    # end
    # result
    select { |todo| todo.title == string }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    result = find_by_title(string)
    result.done! if result
    # find_by_title(string) && find_by_title(string).done!
  end

  # def mark_all_done
  #   each { |todo| todo.done! }
  # end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  private
  
  attr_reader :todos

end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)
# list.mark_done_at(1)
# # # list << 4
# puts list.to_s
# list.mark_all_undone
# p list.all_done
# p list.all_not_done
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../Lesson1/Todo'

class TodoListTest < Minitest::Test
  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to the gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    result = @list.shift
    assert_equal(@todo1, result)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    result = @list.pop
    assert_equal(@todo3, result)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @todo1.done!
    @todo2.done!
    @todo3.done!
    assert_equal(true, @list.done?)
  end

  def test_add_not_todo
    assert_raises(TypeError) { @list.add(3) }
    assert_raises(TypeError) { @list.add('hi') }
  end

  def test_shovel
    todo = Todo.new('test')
    @list << todo
    @todos << todo
    assert_equal(@todos, @list.to_a)
  end

  def test_add
    todo = Todo.new('test')
    @list.add(todo)
    @todos << (todo)
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
    assert_equal(@todo3, @list.item_at(2))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)

    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)

    assert_equal(false, @todo3.done?)

    assert_raises(IndexError) { @list.mark_done_at(50) }
  end

  def test_mark_undone_at
    @list.mark_all_done

    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)

    assert_equal(true, @todo2.done? )

    @list.mark_undone_at(2)
    assert_equal(false, @todo3.done?)

    assert_raises(IndexError) { @list.mark_undone_at(54) }
  end

  def test_remove_at
    assert_equal(@todo2, @list.remove_at(1))
    assert_equal([@todo1, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(45) }
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_to_s
#   output = <<-OUTPUT.chomp.gsub(/^\s+/, '')
# Today's Todos
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to the gym
# OUTPUT

    output = <<~OUTPUT.chomp
    Today's Todos
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to the gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_done
    @list.mark_done_at(1)

    output = <<~OUTPUT.chomp
    Today's Todos
    [ ] Buy milk
    [X] Clean room
    [ ] Go to the gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    @list.mark_all_done

    output = <<~OUTPUT.chomp
    Today's Todos
    [X] Buy milk
    [X] Clean room
    [X] Go to the gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    counter = 0
    @list.each do |todo|
      assert_equal(@todos[counter], todo)
      counter += 1
    end
  end

  def test_each_return
    assert_same(@list, @list.each { })
  end

  def test_select
    @list.mark_done_at(0)
    @done_list = @list.select { |todo| todo.done? }

    @list.remove_at(1)
    @list.remove_at(1)

    assert_equal(@list.title, @done_list.title)
    assert_equal(@list.to_a, @done_list.to_a)
  end

end
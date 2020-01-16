# source: https://gist.github.com/moertel/11091573
def suppress_output
  original_stdout, original_stderr = $stdout.clone, $stderr.clone
  $stderr.reopen File.new(IO::NULL, 'w')
  $stdout.reopen File.new(IO::NULL, 'w')
  yield
ensure
  $stdout.reopen original_stdout
  $stderr.reopen original_stderr
end

class Array
  def my_select
    return [] unless block_given? 
    selections = []
    self.each do |elem|
      selections << elem if suppress_output{yield(elem)}
    end
    selections
  end
end

arr = [1, 2, 3, 4, 5]

p arr.my_select { |num| num.odd? }
p arr.my_select { |num| puts num }
p arr.my_select { |num| num + 1}
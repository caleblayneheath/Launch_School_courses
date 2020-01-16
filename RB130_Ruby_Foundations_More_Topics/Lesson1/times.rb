class Integer
  def my_times
    counter = 0
    while counter < self do
      if block_given?
        yield(counter)
        counter += 1
      else
        break
      end
    end  
  end
end

5.my_times# { |num| puts num } # return value unpredicable(based on block)

5.times# { |num| puts num }
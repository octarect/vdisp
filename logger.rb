class Logger
  def initialize(filename)
    @f = File.open(filename, 'w')
  end

  def output(str)
    @f.puts str
  end

  def close
    @f.close
  end
end

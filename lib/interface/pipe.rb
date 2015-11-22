class Pipe
  def initialize(manager)
    @manager = manager
  end

  def listen
    # Receive command from standard input
    loop do
      @manager.clear_buffer
      command = @manager.input_str
      @manager.execute command
    end
  end
end

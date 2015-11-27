require 'display'
require 'pane'
require 'logger'

class ScreenManager
  def initialize(debug: false)
    @debug_mode = debug
    @display = Display.new
    @logger = Logger.new 'display.log'
    @panes = {}
    @panes[:default] = Pane.new @display, 0, 0, @display.height, @display.width
    @panes[:default].update
  end

  def execute(command)
    log "[received]command=#{command} empty?=<#{command.empty?}>"

    # Get opcode
    m = %r{\/(?<opcode>\S+).*}.match command
    # Call the method which corresponds to the opcode by using reflection
    send "op_#{m[:opcode]}", command
  end

  # Print characters
  def op_print(command)
    regex_normal = %r{\/\S+\s+(?<y>\d+)\s+(?<x>\d+)\s+(?<value>.+)}
    regex_specified = %r{\/\S+\s+(?<name>\S+)\s+(?<y>\d+)\s+(?<x>\d+)\s+(?<value>.+)}

    m0 = regex_normal.match command
    unless m0.nil?
      @panes[:default].render m0[:y].to_i, m0[:x].to_i, m0[:value]
    end

    m1 = regex_specified.match command
    unless m1.nil?
      @panes[m1[:name]].render m1[:y].to_i, m1[:x].to_i, m1[:value]
    end
  end

  # A syntax sugar of print
  def op_p(command)
    op_print command
  end

  # Create pane
  def op_pane(command)
    regex = %r{\/\S+\s+
      (?<name>\S+)\s+
      (?<y>\d+)\s+
      (?<x>\d+)\s+
      (?<height>\d+)\s+
      (?<width>\d+)\s*
      (?<option>.*)
    }x
    m = regex.match command
    unless m.nil?
      @panes[m[:name]] = Pane.new @display, m[:y].to_i, m[:x].to_i,
        m[:height].to_i, m[:width].to_i, ''
      @panes[m[:name]].update
    end
  end

  # Update
  def op_update
    @display.update
  end

  # End
  def op_end
    destroy
  end

  # Clear buffer to input
  def clear_buffer
    @display.clear_line @display.height - 1
  end

  # Log a message to debug
  def log(msg)
    @logger.debug msg if @debug_mode
  end

  def input_ch
    @display.input_ch
  end

  def input_str
    @display.input_str
  end

  def destroy
    @display.destroy
    @log.close if @debug_mode
    exit
  end
end

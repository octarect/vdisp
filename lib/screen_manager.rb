require 'display'
require 'logger'

class ScreenManager
  def initialize(debug: false)
    @debug_mode = debug
    @display = Display.new
    @logger = Logger.new './display.log' if @debug_mode
  end

  def execute(command)
    destroy if command == '/end'
    if command == '/update'
      log '[refreshed]'
      @display.update
    end
    log "[received]command=#{command} empty?=<#{command.empty?}>"
    params = command.split ' '
    @display.put_ch params[0].to_i, params[1].to_i, params[2].to_s
  end

  def clear_buffer
    @display.clear_line @display.height - 1
  end

  def log(msg)
    @logger.output msg if @debug_mode
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


# Pane
# Pane is a general idea of a divided area in terminal screen.
# It enable the program to handle a specified area as a independent stdout area.

class Pane < Array
  def initialize(display, row, col, height, width, material = ' ')
    super height * width, material
    @display = display
    @row = row
    @col = col
    @height = height
    @width = width
  end

  # Add string to buffer
  def render(row, col, str)
    # Replace the buffer with new string
    i = row
    j = col
    str.split('').each do |ch|
      self[i * @width + j] = ch
      j += 1
      if j == @width
        i += 1
        j = col
      end
    end
    update
  end

  def update
    # Make display render each line of buffer
    (0..@height - 1).each do |i|
      line = self.slice i * @width, @width
      @display.put_str @row + i, @col, line.join
    end
  end
end

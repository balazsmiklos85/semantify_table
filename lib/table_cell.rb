class TableCell
  def initialize(value)
    @value = value
  end

  def hide?
    @value == 'Description' || @value.empty?
  end

  def to_heading(level = 1)
    heading_marker = ''
    level.times { heading_marker += '#' }
    "#{heading_marker} #{@value}\n\n"
  end

  def to_label
    "#{@value}: "
  end

  def to_paragraph
    "#{@value}\n\n"
  end
end

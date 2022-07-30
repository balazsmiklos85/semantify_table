class CellMapper
  def initialize(header, cell, column_index)
    @header = header
    @cell = cell
    @index = column_index
  end

  def to_markdown
    if @index.zero?
      @cell.to_heading(3)
    elsif @header.hide?
      @cell.to_paragraph
    else
      @header.to_label + @cell.to_paragraph
    end
  end
end

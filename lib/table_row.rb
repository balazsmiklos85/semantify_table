class TableRow
  def initialize(line = '')
    @cells = line.split(/\|/)
                 .map(&:strip)
                 .map { |cell| replace_formatting cell }
                 .reject(&:empty?)
                 .reject { |cell| header_separator? cell }
  end

  def each_with_index
    @cells.each_with_index { |cell, index| yield cell, index }
  end

  def single_cell?
    @cells.length == 1
  end

  def values?
    !@cells.empty?
  end

  def [](index)
    @cells[index]
  end

  private

  MARKDOWN_FORMATTING_CHARACTERS = /[|*_]/
  ONLY_DASHES_REGEXP = /^-+$/

  def header_separator?(cell)
    ONLY_DASHES_REGEXP.match? cell
  end

  def replace_formatting(cell)
    cell.gsub(MARKDOWN_FORMATTING_CHARACTERS, '')
  end
end

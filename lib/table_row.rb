# frozen_string_literal: true

require_relative 'table_cell'

class TableRow
  def initialize(line = '')
    @cells = line.split(/\|/)
                 .map(&:strip)
                 .map { |cell| replace_formatting cell }
                 .reject(&:empty?)
                 .reject { |cell| header_separator? cell }
                 .map { |cell| TableCell.new cell }
  end

  def single_cell?
    @cells.length == 1
  end

  def to_markdown(header)
    result = []
    @cells.each_with_index do |column, index|
      mapper = CellMapper.new header[index], column, index
      result << mapper
    end
    result.map(&:to_markdown)
  end

  def values?
    !@cells.empty?
  end

  def [](index)
    @cells[index]
  end

  private

  MARKDOWN_FORMATTING_CHARACTERS = /(?<=\s)[|*_](?=\s)/.freeze
  ONLY_DASHES_REGEXP = /^-+$/.freeze

  def header_separator?(cell)
    ONLY_DASHES_REGEXP.match? cell
  end

  def replace_formatting(cell)
    cell.gsub(MARKDOWN_FORMATTING_CHARACTERS, '')
  end
end

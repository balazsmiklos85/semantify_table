# frozen_string_literal: true

require_relative 'cell_mapper'
require_relative 'table_row'

class Table
  def initialize
    @header = TableRow.new
    @rows = []
  end

  def add(line)
    parsed = TableRow.new line
    if !header?
      @header = parsed
    elsif parsed.values?
      @rows << parsed
    end
  end

  def data?
    !@rows.empty?
  end

  def header?
    @header.values?
  end

  def line_count
    @rows.size
  end

  def output
    result = []
    @rows.each do |row|
      if row.single_cell?
        result << row[0].to_heading(2)
        next
      end
      result += row.to_markdown @header
    end
    result
  end
end

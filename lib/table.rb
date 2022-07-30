# frozen_string_literal: true

require_relative 'table_row'

class Table
  def initialize
    @header = TableRow.new
    @data = []
  end

  def add(line)
    parsed = TableRow.new line
    if !header?
      @header = parsed
    elsif parsed.values?
      @data << parsed
    end
  end

  def data?
    !@data.empty?
  end

  def header?
    @header.values?
  end

  def line_count
    @data.size
  end

  def output
    result = []
    @data.each do |data|
      if data.single_cell?
        result << "## #{data[0]}"
        result << ''
        next
      end
      data.each_with_index do |column, index|
        header = @header[index]
        if index.zero?
          result << "### #{column}"
        elsif header == 'Description' || header.empty?
          result << column unless index.zero?
        else
          result << "#{header}: #{column}" unless index.zero?
        end
        result << ''
      end
    end
    result
  end
end

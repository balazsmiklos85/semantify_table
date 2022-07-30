class MarkdownReader
  def initialize(file_name)
    @file_name = file_name
  end

  def read
    output_lines = []
    parsed_table = Table.new
    lines.each do |line|
      if table_part? line
        parsed_table.add line
      else
        output_lines, parsed_table = handle_non_table_line(line, output_lines, parsed_table)
      end
    end
    output_lines
  end

  protected

  def lines
    File.readlines(@file_name)
  end

  private

  def handle_non_table_line(line, output_lines, parsed_table)
    output_lines, parsed_table = end_table_if_any(output_lines, parsed_table)
    output_lines << line
    [output_lines, parsed_table]
  end

  TABLE_FORMATTING = /^\s*\|.*\|\s*$/

  def end_table_if_any(output_lines, parsed_table)
    if parsed_table.data?
      output_lines, parsed_table = render_table(output_lines, parsed_table)
    end
    [output_lines, parsed_table]
  end

  def render_table(output_lines, parsed_table)
    output_lines += parsed_table.output
    [output_lines, Table.new]
  end

  def table_part?(line)
    TABLE_FORMATTING.match?(line)
  end
end

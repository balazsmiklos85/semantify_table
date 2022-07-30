class Table
  def initialize
    @header = []
    @data = []
  end

  def add(line)
    parsed = parse_line line
    if !header?
      @header = parsed
    elsif !parsed.empty?
      @data << parsed
    end
  end

  def data?
    !@data.empty?
  end

  def header?
    !@header.empty?
  end

  def line_count
    @data.size
  end

  def output
    result = []
    @data.each do |data|
      if data.length == 1
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

  def parse_line(line)
    result = line.split(/\|/)
                 .map { |column| column.strip }
                 .map { |column| column.gsub(/[|*]/, '') }
                 .reject { |column| column.empty? }
    if result.any? { |column| /[^-]/.match? column }
      result
    else
      []
    end
  end
end

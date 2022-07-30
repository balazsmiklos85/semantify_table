class MarkdownWriter
  def initialize(file_name)
    @file_name = file_name
  end

  def write(lines)
    File.open(@file_name, 'w+') do |f|
      lines.each { |line| f.puts(line) }
    end
  end
end

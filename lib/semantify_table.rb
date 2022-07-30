#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'semantify_table/version'
require_relative 'table'

module SemantifyTable
  if ARGV.empty?
    puts 'Missing target file. Proper usage: semantify_table markdown_file.md'
    exit 1
  end

  output_lines = []
  table = Table.new
  File.readlines(ARGV[0]).each do |line|
    if /^\s*\|.*\|\s*$/.match?(line)
      table.add line
    else
      if table.data?
        output_lines += table.output
        table = Table.new
      end
      output_lines << line
    end
  end

  File.open(ARGV[1].nil? ? ARGV[0] : ARGV[1], "w+") do |f|
    output_lines.each { |line| f.puts(line) }
  end
end

#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'argument_validator'
require_relative 'markdown_reader'
require_relative 'markdown_writer'
require_relative 'semantify_table/version'
require_relative 'table'

module SemantifyTable
  ArgumentValidator.new(ARGV).validate
  input_file_name, output_file_name = ARGV
  output_file_name = input_file_name if output_file_name.nil?

  converted_lines = MarkdownReader.new(input_file_name).read
  MarkdownWriter.new(output_file_name).write converted_lines
end

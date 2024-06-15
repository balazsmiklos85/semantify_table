# frozen_string_literal: true

class ArgumentValidator
  def initialize(arguments)
    @arguments = arguments
  end

  def validate
    return unless @arguments.empty?

    puts 'Missing source file.'
    puts 'Proper usage: ruby semantify_table source_file.md [target_file]'
    exit 1
  end
end

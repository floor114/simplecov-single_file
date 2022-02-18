# frozen_string_literal: true

require 'terminal-table'

module SimpleCov
  module SingleFile
    module Output
      module Table
        def output(lines)
          table = Terminal::Table.new(
            title: 'SimpleCov Single File Coverage',
            rows: lines,
            style: { all_separators: true }
          )

          puts table
        end
      end
    end
  end
end

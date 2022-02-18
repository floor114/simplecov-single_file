# frozen_string_literal: true

module SimpleCov
  module SingleFile
    module Output
      module Block
        def output(lines)
          puts 'SimpleCov Single File Coverage'

          lines.each do |line|
            puts line.join(' ')
          end
        end
      end
    end
  end
end

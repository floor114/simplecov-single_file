# frozen_string_literal: true

module SimpleCov
  module SingleFile
    class Formatter
      RSPEC_REGEX = %r{r?spec}.freeze
      RB_EXTENSION = '.rb'
      DEFAULT_GREEN_THRESHOLD = 100
      BLOCK_STYLE = :block
      NO_COLOR = '%<message>s'

      def format(result)
        return unless single_file?

        include_output

        @result = result
        lines = []

        if (file = tested_file(result))
          lines << file_message(file)
          lines << coverage_message(file.coverage_statistics[:line])
          lines << branch_coverage_message(file.coverage_statistics[:branch]) if SimpleCov.branch_coverage?
        else
          lines << file_not_found_message
        end

        output(lines)
      end

      private

      attr_reader :result

      def include_output
        if SimpleCov::SingleFile.config.output_style == BLOCK_STYLE
          extend SimpleCov::SingleFile::Output::Block
        else
          extend SimpleCov::SingleFile::Output::Table
        end
      end

      def file_not_found_message
        [SimpleCov::SingleFile.config.output_red_color % { message: 'Could not find tested file.' }]
      end

      def file_message(file)
        ['FILE:', file.project_filename]
      end

      def coverage_message(statistic)
        color = color(statistic.percent, SimpleCov.minimum_coverage[:line].to_f)

        [
          color % { message: 'LINE:' },
          color % { message: "#{statistic.percent.round(2)} -- #{statistic.covered}/#{statistic.total} lines." }
        ]
      end

      def branch_coverage_message(statistic)
        color = color(statistic.percent, SimpleCov.minimum_coverage[:branch].to_f)

        [
          color % { message: 'BRANCH:' },
          color % { message: "#{statistic.percent.round(2)} -- #{statistic.covered}/#{statistic.total} branches." }
        ]
      end

      def color(current_percentage = 100, expected_percentage = 0)
        return NO_COLOR unless SimpleCov::SingleFile.config.output_colorized

        green_threshold = SimpleCov::SingleFile.config.output_green_threshold || DEFAULT_GREEN_THRESHOLD
        orange_threshold = SimpleCov::SingleFile.config.output_orange_threshold || expected_percentage

        if current_percentage >= green_threshold
          SimpleCov::SingleFile.config.output_green_color
        elsif current_percentage >= orange_threshold
          SimpleCov::SingleFile.config.output_orange_color
        else
          SimpleCov::SingleFile.config.output_red_color
        end
      end

      def tested_file(result)
        files_to_scan = result.files.to_a

        filename_args.reverse_each.each_with_object([]) do |arg, new_args|
          break if files_to_scan.size <= 1

          new_args.prepend(arg)

          files_to_scan.select! { |f| f.filename.match?(%r{#{Regexp.escape(new_args.join('/'))}}) }
        end

        files_to_scan[0]
      end

      def single_file?
        ARGV.size == 1 && ARGV[0].match?(RSPEC_REGEX) && File.exist?(ARGV[0]) && File.extname(ARGV[0]) == RB_EXTENSION
      end

      def filename_args
        @filename_args ||= ARGV[0].sub(%r{#{RSPEC_REGEX}/}, '')
                                  .sub(%r{_#{RSPEC_REGEX}#{RB_EXTENSION}}, RB_EXTENSION)
                                  .split('/')
      end
    end
  end
end

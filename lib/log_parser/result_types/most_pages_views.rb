# frozen_string_literal: true

module LogParser
  module ResultTypes
    class MostPagesViews < Base
      private

      def present_results
        data.map do |url, visits|
          puts "#{url} #{visits.size} visits"
        end
      end
    end
  end
end

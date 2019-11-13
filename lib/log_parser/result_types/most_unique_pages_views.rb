# frozen_string_literal: true

module LogParser
  module ResultTypes
    class MostUniquePagesViews < Base

      def call
        make_it_unique
        super
      end

      private

      def present_results
        data.each do |url, visits|
          puts "#{url} #{visits.size} unique visits"
        end
      end

      def make_it_unique
        data.each { |_url, visits| visits.uniq! }
      end
    end
  end
end

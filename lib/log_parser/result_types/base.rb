# frozen_string_literal: true

module LogParser
  module ResultTypes
    class Base
      def initialize(data)
        @data = data
      end

      def call
        sort_descending
        present_results
      end

      private

      def sort_descending
        @data = data.sort_by { |_url, visits| -visits.size }
      end

      attr_accessor :data
    end
  end
end

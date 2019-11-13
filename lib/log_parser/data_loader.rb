# frozen_string_literal: true

module LogParser
  class DataLoader
    attr_accessor :results

    def initialize(file)
      @file = file
      @results = Hash.new { |hash, key| hash[key] = [] }
    end

    def call
      load_content
      results
    end

    private

    def load_content
      File.foreach(file) do |line|
        key, value = *line.gsub('\n', '').split
        results[key] << value
      end
    end

    attr_reader :file
  end
end

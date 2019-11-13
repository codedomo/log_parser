# frozen_string_literal: true

module LogParser
  class ResultsPresenter
    def initialize(data, options = {})
      @data = data
      @options = options
    end

    def call
      present_data
    end

    private

    def present_data
      type = options[:unique] ? 'Unique' : ''

      Object.const_get(
        '::LogParser'  \
        '::ResultTypes'\
        "::Most#{type}PagesViews"
      ).new(data).call
    end

    attr_reader :options, :data
  end
end

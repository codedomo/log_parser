# frozen_string_literal: true

module LogParser
  class FileNotFoundException < StandardError; end

  class CLIHandler
    ACCEPTED_FILE_FORMATS = %w[.log .txt].freeze

    def self.parse(file, options)
      new(file, options).check
    end

    def check
      check_file_size
      validate_extension
      present_results(load_file)
    end

    private

    def validate_extension
      unless ACCEPTED_FILE_FORMATS.include? File.extname(file)
        abort validation_extension_messages
      end
    end

    def check_file_size
      raise FileNotFoundException unless File.exists?(file)
    rescue FileNotFoundException
      abort 'File not found'
    end

    def load_file
      data_loader
    end

    def data_loader
      @data_loader ||= ::LogParser::DataLoader.new(file).call
    end

    def present_results(data, presenter: ::LogParser::ResultsPresenter)
      presenter.new(data, options).call
    end

    def validation_extension_messages
      "Unpermitted file extension. Allowed file extensions: #{ACCEPTED_FILE_FORMATS}"
    end

    def initialize(file, options)
      @file = file
      @options = options
    end

    attr_reader :file, :options, :data
  end
end

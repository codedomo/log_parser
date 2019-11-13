# frozen_string_literal: true

RSpec.describe LogParser::CLIHandler do
  subject { described_class.parse(file, options) }

  describe '#parse' do
    context 'when the file doesn\'t exist' do
      let(:file) { 'missing_file' }
      let(:options) { {} }

      it 'raises a SystemExit error' do
        expect { subject }.to raise_error(SystemExit, 'File not found')
      end
    end

    context 'when the file extension is wrong' do
      let(:file) { 'spec/fixtures/files/wrong_file.jpg' }
      let(:options) { {} }

      it 'returns validation messages' do
        expect { subject }
          .to raise_error(SystemExit,
            "Unpermitted file extension. Allowed file extensions: #{LogParser::CLIHandler::ACCEPTED_FILE_FORMATS}")
      end
    end

    context 'when the file exists and has correct extension' do
      let(:file) { 'spec/fixtures/files/log_file.log' }
      let(:options) { {} }

      let(:data_loader) { instance_double('::LogParser::DataLoader', file: file, results: {}, call: {}) }
      let(:result_presenter) { instance_double('::LogParser::ResultsPresenter', call: true) }

      before do
        allow(::LogParser::DataLoader).to receive(:new).and_return(data_loader)
        allow(::LogParser::ResultsPresenter).to receive(:new).and_return(result_presenter)
      end

      it 'invokes DataLoader', :aggregate_failures do
        expect(::LogParser::DataLoader).to receive(:new).with(file)
        expect(data_loader).to receive(:call)

        subject
      end

      it 'invokes ResultsPresenter', :aggregate_failures do
        expect(::LogParser::ResultsPresenter).to receive(:new).with(data_loader.results, options)
        expect(result_presenter).to receive(:call)

        subject
      end
    end
  end
end

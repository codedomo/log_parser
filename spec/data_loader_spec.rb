# frozen_string_literal: true

RSpec.describe LogParser::DataLoader do
  subject { described_class.new(file) }

  describe '#call' do
    let(:file) { 'spec/fixtures/files/log_file.log' }

    it 'creates hash with key as url and array with ip\'s' do
      subject.call

      expect(subject.results).to eq(
        '/help_page/1' => [
          '126.318.035.038',
          '123.311.055.068'
        ],
        '/contact' => ['184.123.665.067'],
        '/home'    => ['184.123.665.067'],
        '/about/2' => ['444.701.448.104']
      )
    end
  end
end

# frozen_string_literal: true

RSpec.describe LogParser::ResultTypes::MostUniquePagesViews do
  subject { described_class.new(data) }

  describe '#call' do
    let(:data) do
      {
        '/help_page/1' =>
          [
            '126.318.035.038',
            '126.318.035.038'
          ],
        '/contact' => ['184.123.665.067'],
        '/home'    => ['184.123.665.067'],
        '/about/2' => ['444.701.448.104']
      }
    end

    it 'prints the results with unique visits to the console', :aggregate_failures do
      expect(STDOUT).to receive(:puts).exactly(4).times
      subject.call
    end
  end
end

# frozen_string_literal: true

RSpec.describe LogParser::ResultsPresenter do
  subject { described_class.new(data, options) }

  describe '#call' do
    let(:data) do
      {
        '/help_page/1' => [
          '126.318.035.038',
          '123.311.055.068'
        ],
        '/contact' => ['184.123.665.067'],
        '/home'    => ['184.123.665.067'],
        '/about/2' => ['444.701.448.104']
      }
    end

    before do
      allow(result_class).to receive(:new)
        .with(data).and_return(result_class_instance)

      allow(result_class_instance).to receive(:call)
    end

    shared_examples 'invokes class type', :aggregate_failures do |class_type|
      it "invokes #{class_type} type" do
        expect(class_type).to receive(:new).with(data)
        expect(result_class_instance).to receive(:call)

        subject.call
      end
    end

    context 'when no options are provided' do
      let(:options) { {} }
      let(:result_class) { ::LogParser::ResultTypes::MostPagesViews }
      let(:result_class_instance) { instance_double('LogParser::MostPagesViews') }

      it_behaves_like 'invokes class type', ::LogParser::ResultTypes::MostPagesViews
    end

    context "when options contain 'unique' key" do
      let(:options) { { unique: true } }
      let(:result_class) { ::LogParser::ResultTypes::MostUniquePagesViews }
      let(:result_class_instance) { instance_double('LogParser::MostUniquePagesViews') }

      it_behaves_like 'invokes class type', ::LogParser::ResultTypes::MostUniquePagesViews
    end
  end
end

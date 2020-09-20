# frozen_string_literal: true


require 'atome'

describe Atome do
  shared_examples 'ensure atome color is red' do
    it 'should be red' do
      expect(subject.color).to eq(:red)
    end
  end

  subject do
    described_class.new(params)
  end

  let(:params) { {} }

  context '#initialize' do
    context 'without parameter' do
      it { is_expected.to be_an(Atome) }
    end
#color method tests
    context 'with a color parameter' do
      let(:params) { { color: :red } }

      include_examples 'ensure atome color is red'
    end
  end

  context '#color' do
    before do
      expect(subject.color(:red)).to eq(subject)
    end

    include_examples 'ensure atome color is red'
  end

  context '#color=' do
    before do
      subject.color = :red
    end

    include_examples 'ensure atome color is red'
  end
end

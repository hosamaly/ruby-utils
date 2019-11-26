# frozen_string_literal: true

# std library
require 'date'

# library under test
require 'range'

RSpec.describe Range do
  let(:beginning) { Faker::Number.number.to_i }
  let(:ending) { beginning + rand(1000) }

  subject(:inclusive_range) { beginning..ending }
  let(:exclusive_range) { beginning...ending }

  let(:empty_inclusive_range) { ending..beginning }
  let(:empty_exclusive_range) { ending...beginning }

  let(:before_and_including) { (beginning - 1)..(ending + 0) }
  let(:after_and_including)  { (beginning + 0)..(ending + 1) }
  let(:narrower_range)       { (beginning + 1)..(ending - 1) }
  let(:wider_range)          { (beginning - 1)..(ending + 1) }

  describe '#equivalent_to?' do
    context 'is false' do
      specify 'for a range that begins earlier' do
        expect(subject.equivalent_to?(before_and_including)).to eq false
      end

      specify 'for a range that ends later' do
        expect(subject.equivalent_to?(after_and_including)).to eq false
      end

      specify 'for a range that is narrower' do
        expect(subject.equivalent_to?(narrower_range)).to eq false
      end

      specify 'for a range that is wider' do
        expect(subject.equivalent_to?(wider_range)).to eq false
      end
    end

    context 'for an inclusive range with the same values' do
      # don't use subject; otherwise we could be testing reference equality
      specify { expect((beginning..ending).equivalent_to?(beginning..ending)).to eq true }
    end

    context 'for an exclusive range with the same values' do
      specify { expect((beginning...ending).equivalent_to?(beginning...ending)).to eq true }
    end

    context 'for an inclusive and an exclusive range that completely overlap' do
      specify do
        inclusive_range = beginning..ending
        exclusive_range = beginning...(ending+1)
        aggregate_failures do
          expect(inclusive_range.equivalent_to?(exclusive_range)).to eq true
          expect(exclusive_range.equivalent_to?(inclusive_range)).to eq true
        end
      end
    end

    context 'for two empty ranges' do
      specify do
        aggregate_failures do
          expect(empty_inclusive_range.equivalent_to?(empty_exclusive_range)).to eq true
          expect(empty_exclusive_range.equivalent_to?(empty_inclusive_range)).to eq true
        end
      end
    end

    context 'for non-numeric ranges' do
      it 'works with strings' do
        range = ('abc'..'def')
        expect(range.equivalent_to?(range)).to eq true
        expect(range.equivalent_to?('abc'...'xyz')).to eq false
      end

      it 'works with dates' do
        range = (Date.parse('2010-01-01')..Date.parse('2020-01-01'))
        expect(range.equivalent_to?(range)).to eq true
        expect(range.equivalent_to?(Date.parse('2000-01-01')...Date.parse('2030-01-01'))).to eq false
      end
    end
  end
end

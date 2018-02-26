require 'spec_helper'
require 'timecop'
require 'active_support'
require 'active_support/core_ext'

describe DateUtils do
  let(:last_of_year) { Date.parse('2015-12-31') }

  describe '#months_between' do
    let(:date_a)        { Date.parse('2017-07-05') }
    let(:date_b)        { Date.parse('2017-10-20') }
    let(:date_c)        { Date.parse('2015-07-15') }
    let(:last_of_month) { Date.parse('2015-01-31') }

    it { expect(described_class.months_between(date_a, date_a + 3.months)).to eq 3 }
    it { expect(described_class.months_between(date_a + 3.months, date_a)).to eq(-3) }
    it { expect(described_class.months_between(date_c, date_b)).to eq 27 }
    it { expect(described_class.months_between(last_of_month, last_of_month + 1.day)).to eq 1 }
    it { expect(described_class.months_between(last_of_year, last_of_year + 1.day)).to eq 1 }
  end

  describe '#closest_date_from' do
    context 'when being on year A and mmdd would be on year A + 1' do
      let(:year_A) { 2016 }
      let(:format) { %r{(?<month>\d{2})[/-]?(?<day>\d{2})} }
      before do
        Timecop.freeze(Date.parse("#{year_A}-12-20"))
      end
      let(:mmdd_year_ahead) { '01/05' }
      let(:mmdd_same_year)  { '12/30' }

      it do
        expect(described_class.closest_date_from(mmdd_year_ahead, format).year).to eq(year_A + 1)
      end
      it do
        expect(described_class.closest_date_from(mmdd_same_year, format).year).to eq(year_A)
      end
    end

    context 'when being on year A and mmdd would be on year A - 1' do
      let(:year_A) { 2017 }
      let(:format) { %r{(?<month>\d{2})[/-]?(?<day>\d{2})} }
      before do
        Timecop.freeze(Date.parse("#{year_A}-01-02"))
      end
      let(:mmdd_year_behind)  { '12/30' }
      let(:mmdd_same_year)    { '01/20' }

      it do
        expect(described_class.closest_date_from(mmdd_year_behind, format).year)
          .to eq(year_A - 1)
      end
      it do
        expect(described_class.closest_date_from(mmdd_same_year, format).year)
          .to eq(year_A)
      end
    end
  end

  describe '#closest_date_from_to' do
    context 'when both are in the same year' do
      it 'returns the same year for the resulting date' do
        expect(described_class.closest_date_from_to('30/12', Date.new(2016, 12, 29)).year)
          .to eq(2016)
        expect(described_class.closest_date_from_to('30/12', Date.new(2016, 12, 29)).year)
          .to eq(2016)
        expect(described_class.closest_date_from_to('30/12', Date.new(2016, 12, 29)).year)
          .to eq(2016)
      end
    end
    context 'when they are from different years and the reference date is higher' do
      let(:date_and_month) { '30/12' }
      let(:reference_date) { Date.new(2017, 1, 20) }
      it 'returns the previous year for the resulting date' do
        expect(described_class.closest_date_from_to('10/12', Date.new(2017, 1, 30)).year)
          .to eq(2016)
        expect(described_class.closest_date_from_to('01/12', Date.new(2017, 1, 31)).year)
          .to eq(2016)
      end
    end
    context 'when they are from different years and the reference date is lower' do
      it 'returns the next year for the resulting date' do
        expect(described_class.closest_date_from_to('10/01', Date.new(2016, 12, 30)).year)
          .to eq(2017)
        expect(described_class.closest_date_from_to('01/01', Date.new(2016, 12, 31)).year)
          .to eq(2017)
      end
    end
  end
end

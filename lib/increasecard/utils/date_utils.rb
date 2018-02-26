require 'active_support'
require 'active_support/core_ext'

module DateUtils
  DEFAULT_FORMAT = %r{(?<day>\d{2})[/-]?(?<month>\d{2})}

  module_function

  def months_between(date_a, date_b)
    12 * (date_b.year - date_a.year) + date_b.month - date_a.month
  end

  # This method intends to remove cases like:
  # => being in xx Jan 2017 and '20/12', logic would give 20/12/2016, not 2017
  # => being in 31 Dec 2016 and '01/01', logic would give 01/01/2017, not 2016
  def closest_date_from(date_and_month, format = DEFAULT_FORMAT)
    DateUtils.closest_date_from_to(date_and_month, DateTime.now, format)
  end

  def closest_date_from_to(date_and_month, reference_date, format = DEFAULT_FORMAT)
    date_and_month = date_and_month.match(format)
    dates = [-1, 0, 1].map do |diff|
      Date.new(reference_date.year + diff, date_and_month[:month].to_i, date_and_month[:day].to_i)
    end
    dates.min do |date1, date2|
      (date1 - reference_date).abs <=> (date2 - reference_date).abs
    end
  end
end

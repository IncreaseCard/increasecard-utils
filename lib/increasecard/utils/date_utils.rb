require 'active_support'
require 'active_support/core_ext'

module DateUtils
  module_function

  def months_between(date_a, date_b)
    12 * (date_b.year - date_a.year) + date_b.month - date_a.month
  end

  # This method intends to remove cases like:
  # => being in xx Jan 2017 and '20/12', logic would give 20/12/2016, not 2017
  # => being in 31 Dec 2016 and '01/01', logic would give 01/01/2017, not 2016
  def closest_date_from(date_and_month)
    DateUtils.closest_date_from_to(date_and_month, DateTime.now)
  end

  def closest_date_from_to(date_and_month, reference_date, format = '%m%d')
    date_and_month = Date.strptime(date_and_month.tr('-/', ''), format)
    month_dif = DateUtils.months_between(reference_date, date_and_month)
    month_dif.abs > 2 ? date_and_month - (month_dif <=> 0).year : date_and_month
  end
end

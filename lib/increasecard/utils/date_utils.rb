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
  def closest_date_from(mmdd)
    mmdd = Date.strptime(mmdd.tr('-/', ''), '%m%d')
    month_dif = DateUtils.months_between(DateTime.now, mmdd)
    month_dif.abs > 2 ? mmdd - (month_dif <=> 0).year : mmdd
  end
end

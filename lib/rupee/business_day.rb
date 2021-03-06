require "rupee/mixins/find_instance"

module Rupee
  # A business day convention, used to determine the next business day should a
  # calculated payment date fall on a non-working day
  class BusinessDay
    autoload :ACTUAL,             "rupee/business_day/actual"
    autoload :FOLLOWING,          "rupee/business_day/following"
    autoload :MODIFIED_FOLLOWING, "rupee/business_day/modified_following"
    autoload :MODIFIED_PREVIOUS,  "rupee/business_day/modified_previous"
    autoload :PREVIOUS,           "rupee/business_day/previous"

    # A description of the business day and where it's often found
    attr :description
    # The formula for calculated the next business day
    attr :block

    # Create a new business day object
    #
    # Configuration options
    #
    # * <tt>:calendar</tt> - The calendar to use for calculating holidays and
    #   days off
    def initialize(description, opts = {}, &block)
      @description = description
      @block = block
    end

    # Calculates the next business day according to the calendar and the date
    # given
    def next_day(date, calendar)
      block.call date, calendar
    end

    class << self
      include FindInstance
    end
  end
end

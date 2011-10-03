require "rupee/mixins/find_instance"

module Rupee
  # A business day convention, used to determine the next business day should a
  # calculated payment date fall on a non-working day
  class BusinessDay
    include FindInstance

    # A description of the business day and where it's often found
    attr :description
    # The formula for calculated the next business day
    attr :block
    # The calendar used for calculating holidays and days off
    attr :calendar

    # Create a new business day object
    #
    # Configuration options
    #
    # * <tt>:calendar</tt> - The calendar to use for calculating holidays and
    #   days off
    def initialize(description, opts = {}, &block)
      opts = { :calendar => :us }.merge opts

      @description = description
      @block = block

      self.calendar=(opts[:calendar])
    end

    def calendar=(calendar)  # :nodoc:
      @calendar = Calendar.find(calendar)
    end
  end
end

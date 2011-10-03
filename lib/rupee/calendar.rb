require "rupee/mixins/find_instance"

module Rupee
  # An object representing a calendar, for use in determining the next payout
  # date for a cash flow. Simple example:
  #
  #   require "rupee/calendar"
  #
  #   module Rupee
  #     class Calendar
  #       # It's recommended that you store your calendar inside the Calendar
  #       # class, as that way you'll have access to them as "constants." Also,
  #       # it gives you access to the month constants (JANUARY, FEBRUARY,
  #       # MARCH, etc.)
  #       MyCalendar = Rupee::Calendar.new("Sample calendar")
  #
  #       # Weekends
  #       MyCalendar.has_weekends_off
  #  
  #       # Thanksgiving (fourth Thursday of November
  #         MyCalendar.has_day_off_on :thanksgiving do |date|
  #         date.month == NOVEMBER && date.thursday? && week_of(date) == 4
  #       end
  #    
  #       # Christmas (December 25 or nearest weekday)
  #       MyCalendar.has_day_off_on :christmas do |date|
  #         date.month == DECEMBER && nearest_weekday(date, 25)
  #       end
  #    
  #       # New Year's Day (January 1 or next weekday)
  #       MyCalendar.has_day_off_on :new_years do |date|
  #         date.month == JANUARY && next_weekday(date, 1)
  #       end
  #     end
  #   end
  #
  #   # Christmas falls on a Sunday in 2011...
  #   Rupee::Calendar::MyCalendar.day_off?(Time.new(2011, 12, 25))
  #   # => true
  #    
  #   # ... so we have the following Monday off...
  #   Rupee::Calendar::MyCalendar.day_off?(Time.new(2011, 12, 26))
  #   # => true
  #    
  #   # ...then it's back to work
  #   Rupee::Calendar::MyCalendar.day_off?(Time.new(2011, 12, 27))
  #   # => false
  #
  # You can also inherit from other calendars easily:
  #
  #   require "rupee/calendar"
  #
  #   class Rupee::Calendar
  #     # Pirates generally observe the Federal Reserve holiday schedule
  #     Blackbeard = US.copy
  #
  #     # But they do observe Talk Like a Pirate Day
  #     Blackbeard.has_day_off_on :talk_like_a_pirate_day do |date|
  #       date.month == SEPTEMBER && date.day == 19
  #     end
  #
  #     # And curse the Spanish Crown
  #     Blackbeard.remove_day_off_for :columbus_day
  #   end
  #
  #   # Talk Like a Pirate Day
  #   Rupee::Calendar::Blackbeard.day_off?(Time.new(2011, 9, 19))
  #   # => true
  #   Rupee::Calendar::US.day_off?(Time.new(2011, 9, 19))
  #   # => false
  #
  #   # Columbus Day
  #   Rupee::Calendar::Blackbeard.day_off?(Time.new(2011, 10, 10))
  #   # => false
  #   Rupee::Calendar::US.day_off?(Time.new(2011, 10, 10))
  #   # => true
  class Calendar
    # A constant representing the month of January
    JANUARY   = 1
    # A constant representing the month of February
    FEBRUARY  = 2
    #  A constant representing the month of March
    MARCH     = 3
    # A constant representing the month of April
    APRIL     = 4
    # A constant representing the month of May
    MAY       = 5
    # A constant representing the month of June
    JUNE      = 6
    # A constant representing the month of July
    JULY      = 7
    # A constant representing the month of August
    AUGUST    = 8
    # A constant representing the month of September
    SEPTEMBER = 9
    # A constant representing the month of October
    OCTOBER   = 10
    # A constant representing the month of November
    NOVEMBER  = 11
    # A constant representing the month of December
    DECEMBER  = 12

    autoload :Japan, "rupee/calendar/japan"
    autoload :US, "rupee/calendar/us"

    # A description of the calendar
    attr :description
    # Functions used to determine whether a day is off
    attr :days_off

    # Builds a calendar
    def initialize(description)
      @description = description
      @days_off = {}
    end

    # Makes a copy of the calendar
    def copy
      new_cal = Calendar.new @description.dup
      
      @days_off.each_pair do |key, day_off|
        new_cal.days_off[key] = day_off
      end

      new_cal
    end

    # Provides a function telling that calendar how to evaluate whether a
    # particular day is off. Note that within this block you can use the
    # helper methods week_of, nearest_weekday, next_weekday and
    # previous_weekday:
    #
    #   # Thanksgiving (fourth Thursday of November
    #   MyCalendar.has_day_off_on :thanksgiving do |date|
    #     date.month == NOVEMBER && date.thursday? && week_of(date) == 4
    #   end
    #
    #   # Christmas (December 25 or nearest weekday)
    #   MyCalendar.has_day_off_on :christmas do |date|
    #     date.month == DECEMBER && nearest_weekday(date, 25)
    #   end
    #
    #   # New Year's Day (January 1 or next weekday)
    #   MyCalendar.has_day_off_on :new_years do |date|
    #     date.month == JANUARY && next_weekday(date, 1)
    #   end
    def has_day_off_on(key, &block)
      @days_off[key] = block
    end

    # Removes the day off for the specified key
    def remove_day_off_for(key)
      @days_off.delete key
    end

    # A simple helper method for the commonality among most countries that
    # weekends are not workdays or trading days:
    #
    #   MyCalendar.has_weekends_off
    def has_weekends_off
      @days_off[:weekends] = Proc.new do |date|
        date.saturday? || date.sunday?
      end
    end

    # Returns true if the specified date is a holiday or day off
    def day_off?(date)
      @days_off.each_value do |day_off|
        return true if day_off.call(date)
      end

      false
    end

    class << self
      include FindInstance

      # Calculates the week of the month in which the given date falls
      def week_of(date)
        (date.day - 1) / 7 + 1
      end

      # Whether the provided date falls in the last week of the month
      def last_week?(date)
        case date.month
        when 9, 4, 6, 11
          # Thirty days hath September
          # April, June and November
          date.day > 23
        when 1, 3, 5, 7, 8, 10, 12
          # All the rest have thirty-one
          date.day > 24
        when 2
          # Save February, with twenty-eight days clear
          # And twenty-nine each leap year ;)
          date.day > (date.year % 4 == 0 && (date.year % 100 != 0 || date.year % 400 == 0)) ? 22 : 21
        end
      end

      # Calculates whether the provided date is the nearest weekday relative
      # to the provided day of the month
      def nearest_weekday(date, day)
        case date.wday
        when 1     # Monday
          date.day.between?(day, day + 1)
        when 5     # Friday
          date.day.between?(day - 1, day)
        when 0, 6  # Weekends
          false
        else       # Tuesday - Thursday
          date.day == day
        end
      end
      
      # Calculates whether the provided date is the nearest weekday relative
      # to the provided day of the month
      def next_weekday(date, day)
        case date.wday
        when 1     # Monday
          date.day.between?(day, day + 2)
        when 0, 6  # Weekends
          false
        else       # Tuesday - Friday
          date.day == day
        end
      end

      # Calculates whether the provided date is the nearest weekday relative
      # to the provided day of the month
      def previous_weekday(date, day)
        case date.wday
        when 5     # Friday
          date.day.between?(day - 2, day)
        when 0, 6  # Weekends
          false
        else       # Monday - Thursday
          date.day == day
        end
      end
    
      # Calculates whether the provided date is the day requested or, if the
      # day requested falls on a Sunday, the following Monday
      def next_monday_if_sunday(date, day)
        case date.wday
        when 1     # Monday
          date.day.between?(day, day + 1)
        when 0, 6  # Weekends
          false
        else       # Tuesday - Friday
          date.day == day
        end
      end
    end
  end
end

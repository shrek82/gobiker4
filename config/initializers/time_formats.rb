#   time = Time.now                     # => Thu Jan 18 06:10:17 CST 2007
#
#   time.to_formatted_s(:time)          # => "06:10"
#   time.to_s(:time)                    # => "06:10"
#
#   time.to_formatted_s(:db)            # => "2007-01-18 06:10:17"
#   time.to_formatted_s(:number)        # => "20070118061017"
#   time.to_formatted_s(:short)         # => "18 Jan 06:10"
#   time.to_formatted_s(:long)          # => "January 18, 2007 06:10"
#   time.to_formatted_s(:long_ordinal)  # => "January 18th, 2007 06:10"
#   time.to_formatted_s(:rfc822)        # => "Thu, 18 Jan 2007 06:10:17 -0600"
#
# == Adding your own time formats to +to_formatted_s+
# You can add your own formats to the Time::DATE_FORMATS hash.
# Use the format name as the hash key and either a strftime string
# or Proc instance that takes a time argument as the value.
#
#   # config/initializers/time_formats.rb
#   Time::DATE_FORMATS[:month_and_year] = "%B %Y"
#   Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }

Time::DATE_FORMATS[:ymd] = "%Y-%m-%d"
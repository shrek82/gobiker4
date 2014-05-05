# config/initializers/date_time_formats.rb
Time::DATE_FORMATS.merge!(
    :full => '%Y-%m-%d %H:%M:%S',
    :md => '%m-%d',
    :time => '%I:%M %p'
)
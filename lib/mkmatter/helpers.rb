def get_time_zone_full(time_object)
  require 'tzinfo'
  offset = time_object.utc_offset
  if offset.is_a?(Integer)
    offset = offset / 3600 # Convert seconds to hours
  elsif offset.is_a?(String) && offset.include?(':')
    # If the offset is in the format "+HH:MM" or "-HH:MM"
    parts = offset.split(':')
    offset = parts[0].to_i + (parts[1].to_i / 60.0)

  elsif offset.is_a?(String) && offset.length == 1
    # Single character offset, e.g. "Z" for UTC, or "A" for UTC-1
    # Not commonly used, but handling it for completeness
    case offset.upcase
      when 'Z'
        offset = '+0000' # UTC
      when 'A'
        offset = '+0100' # UTC+1
      when 'B'
        offset = '+0200' # UTC+2
      when 'C'
        offset = '+0300' # UTC+3
      when 'D'
        offset = '+0400' # UTC+4
      when 'E'
        offset = '+0500' # UTC+5
      when 'F'
        offset = '+0600' # UTC+6
      when 'G'
        offset = '+0700' # UTC+7
      when 'H'
        offset = '+0800' # UTC+8
      when 'I'
        offset = '+0900' # UTC+9
      when 'K'
        offset = '+1000' # UTC+10
      when 'L'
        offset = '+1100' # UTC+11
      when 'M'
        offset = '+1200' # UTC+12
      when 'N'
        offset = '-0100' # UTC-1
      when 'O'
        offset = '-0200' # UTC-2
      when 'P'
        offset = '-0300' # UTC-3
      when 'Q'
        # US Eastern Time
        # US Eastern Time is UTC-4, but it can also be UTC-5 during Daylight Saving Time
        offset = '-0400' # UTC-4
        return 'Eastern Time (US & Canada)' if time_object.zone == 'EDT' || time_object.zone == 'EST'
      when 'R' # US Central Time
        # US Central Time is UTC-5, but it can also be UTC-6 during Daylight Saving Time
        offset = '-0500' # UTC-5
        return 'Central Time (US & Canada)' if time_object.zone == 'CDT' || time_object.zone == 'CST'
      when 'S'
        # US Mountain Time
        # US Mountain Time is UTC-6, but it can also be UTC-7 during Daylight Saving Time
        offset = '-0600' # UTC-6
        return 'Mountain Time (US & Canada)' if time_object.zone == 'MDT' || time_object.zone == 'MST'
      when 'T'
        # US Pacific Time
        # US Pacific Time is UTC-7, but it can also be UTC-8 during Daylight Saving Time
        offset = '-0700' # UTC-7
        return 'Pacific Time (US & Canada)' if time_object.zone == 'PDT' || time_object.zone == 'PST'
      when 'U'
        # US Alaska Time
        # US Alaska Time is UTC-8, but it can also be UTC-9 during Daylight Saving Time
        offset = '-0800' # UTC-8
        return 'Alaska Time (US & Canada)' if time_object.zone == 'AKDT' || time_object.zone == 'AKST'
      when 'V'
        # US Hawaii-Aleutian Time
        # US Hawaii-Aleutian Time is UTC-9, but it can also be UTC-10 during Daylight Saving Time
        # Note: Hawaii does not observe Daylight Saving Time
        offset = '-0900' # UTC-9
      when 'W'
        offset = '-1000' # UTC-10
      when 'X'
        offset = '-1100' # UTC-11
      when 'Y'
        offset = '-1200' # UTC-12
      else
        raise ArgumentError, "Invalid time zone offset character: #{offset}"
    end
  else
    raise ArgumentError, "Invalid time zone offset format: #{offset}"
  end
  # puts "Offset: #{offset}"
end
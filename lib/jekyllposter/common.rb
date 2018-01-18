require 'highline'
require 'active_support/all'

module Jekyllposter
  module Common
    attr_accessor :time_zone
    # @param [HighLine] hl A highline context
    def get_title(hl)
      hl.ask "Title: "
    end
    
    # @param [HighLine] hl A highline context
    def get_tags(hl)
      hl.ask("Tags? (comma separated list) ", -> (str) {str.split(/,\s*/)})
    end
    
    # @param [HighLine] hl A highline context
    def get_categories(hl)
      hl.ask("Categories? (comma separated list) ", -> (str) {str.split(/,\s*/)})
    end
    
    # @param [HighLine] hl A highline context
    def get_published(hl)
      hl.agree("Do you want to publish this immediately? ", true)
    end
    
    # @param [HighLine] hl A highline context
    def get_time_zone(hl)
      timezone = nil
      custom   = nil
      timezone = hl.choose do |m|
        m.header = "Time Zone? (select by number)"
        m.choice "Eastern Time (US & Canada)"
        m.choice "Central Time (US & Canada)"
        m.choice :neither
        m.prompt = "? "
      end
      indexes  = {
          "Eastern Time (US & Canada)": '1',
          "Central Time (US & Canada)": '2'
      }
    
    end
    
    # @param [HighLine] hl A highline context
    def get_date(hl)
      hl.say "Getting Time & Date."
      3.times {sleep(1); print '.'}
    end
  end
end

require 'highline'
require 'active_support/all'

module Mkmatter
  module Common
    attr_accessor :time_zone
    # @param [HighLine] hl A highline context
    # @return [String]
    def get_title(hl)
      title = hl.ask 'Title: '
      if hl.agree("Would you like it 'titleized' (Title instead of title)? ", true)
        title.titleize
      else
        title
      end
    end
    
    # @param [HighLine] hl A highline context
    # @return [String]
    def get_tags(hl)
      hl.ask 'Tags? (this would be a comma separated list.) ', -> (str) {str.split(',')}
    end
    
    # @param [HighLine] hl A highline context
    # @return [String]
    def get_categories(hl)
      hl.ask 'Categories? (space separated list) ', -> (str) {str.split(' ')}
    end
    
    # @param [HighLine] hl A highline context
    # @return [String]
    def get_time_zone(hl)
      custom   = nil
      timezone = hl.choose do |m|
        m.header = 'Time Zone? (select by number)'
        m.choice('Eastern Time (US & Canada)') do
          return 'Eastern Time (US & Canada)'
        end
        m.choice('Central Time (US & Canada)') do
          return 'Central Time (US & Canada)'
        end
        m.choice :neither
        m.prompt = '? '
      end
      case
        when timezone == :neither
          custom = hl.ask('Other Time Zone: ', String)
      end
      if custom
        hl.say('Checking TimeZone Validity')
        print '.'
        sleep(0.05)
        5.times do
          print '.'
          sleep(0.05)
          puts ''
          TimeZone.find_tzinfo custom
        end
        custom
      end
    end
    
    # @param [HighLine] hl A highline context
    # @return [String]
    def get_file_format(hl)
      hl.choose do |menu|
        menu.header = 'Choose whether you want HTML or Markdown (md)'
        menu.choice 'html'
        menu.choice 'md'
        menu.prompt = '? '
      end
    end
  end
end

require 'highline'
require 'active_support/all'

module Jekyllposter
  module Common
    attr_accessor :time_zone
    # @param [HighLine] hl A highline context
    def get_title(hl)
      hl.ask 'Title: '
    end
    
    # @param [HighLine] hl A highline context
    def get_tags(hl)
      hl.ask('Tags? (space separated list) ', -> (str) {str.split(' ')})
    end
    
    # @param [HighLine] hl A highline context
    def get_categories(hl)
      hl.ask('Categories? (space separated list) ', -> (str) {str.split(' ')})
    end
    
    # @param [HighLine] hl A highline context
    def get_published(hl)
      hl.agree('Do you want to publish this immediately? ', true)
    end
    
    # @param [HighLine] hl A highline context
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
      case timezone
        when :neither
          custom = hl.ask('Other Time Zone: ', String)
        else
      end
      if custom
        hl.say('Checking TimeZone Validity')
        print '.'
        sleep(0.1)
        5.times do
          print '.'
          sleep(0.1)
          puts ''
          TimeZone.find_tzinfo custom
        end
        custom
      end
    end
    
    # @param [HighLine] hl A highline context
    def get_date(hl)
      hl.say 'Getting Time & Date '
      print '.'
      sleep(0.1)
      5.times do
        sleep(0.1); print '.'
      end
      puts @time_zone.class
      puts ''
    end

    # @param [HighLine] hl A highline context
    def get_file_format(hl)
      file_format = hl.choose do |menu|
        menu.header = 'Choose whether you want HTML or Markdown (md)'
        menu.choice 'html'
        menu.choice 'md'
        menu.prompt = '? '
      end
      file_format
    end
  end
end

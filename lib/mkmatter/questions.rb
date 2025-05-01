require 'highline'
require 'highline/color'
require 'ostruct'
module Mkmatter
  module Questions
    def self.ask(cls)

      known_questions = const_get(cls).methods.sort.delete_if { |m| m.to_s !~ /^get_.*$/ }
      known_questions.each do |m|
        @answers[:layout] = cls.to_s.lower
        @answers[m.to_s.gsub(/^get_[0-9]{3}_/, '')] = method(m).call
      end
      @answers
    end

    class Post
      attr :answers
      @hl = HighLine.new

      def ask
        known_questions = methods.sort.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[:layout] = 'post'
          @answers[m.to_s.gsub(/^get_[0-9]{3}_/, '')] = method(m).call
        end
        @answers
      end

      # @!visibility private
      def initialize
        @answers = OpenStruct.new
        @hl = HighLine.new
      end

      def get_001_title
        hl = @hl
        title = hl.ask 'Title: '
        if hl.agree("Would you like it 'titleized' (Title instead of title)? ")
          title.titleize
        else
          title
        end
      end

      # @return [Array]
      def get_002_tags
        hl = @hl
        hl.ask("Tags? (write one on each line, then type '.') ") do |q|
          q.gather = '.'
        end
      end

      # @return [Array]
      def get_003_categories
        hl = @hl
        hl.ask("Categories? (write one on each line, then type '.') ") do |q|
          q.gather = '.'
        end
      end

      # @return [String]
      def get_004_time_zone
        hl = @hl
        custom = nil
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
        custom = hl.ask('Other Time Zone: ', String) if timezone == :neither
        return unless custom

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

      # @return [String]
      def get_005_file_format
        hl = @hl
        hl.choose do |menu|
          menu.header = 'Choose whether you want HTML or Markdown'
          menu.choice 'html' do
            return 'html'
          end
          menu.choice 'md' do
            return 'md'
          end
          menu.prompt = '? '
        end
      end
      # @return [String]
      def get_006_extra_fields
        hl = @hl
        custom_fields = nil
        if hl.agree('Do you want to add custom fields? (usable as {{LAYOUT_TYPE.FIELD}} in templates) ', true)
          hl.say('Your fields should be inputted as FIELD=>TEXT HERE')
          hl.say("Type 'EOL' on a new line then press Enter when you are done.")
          hl.say("<% color('NOTE', :bold, :red) %>: Input is <% color('NOT', :bold, :red) %> evaluated!")
          custom_fields = hl.ask('Fields?') do |q|
            q.gather = /^EOL$/
          end
        end
        if custom_fields
          fields = Hash.new
          custom_fields.each do |field|
            field = field.split(/=>/)
            fields.store(field[0].to_s, field[1])
          end
          
        elsif custom_fields.nil?
          hl.say('No extra fields were added.')
          return
        else
        end
        custom_fields
      end
      # @return [OpenStruct]
    end
    class Page
      attr :answers
      @hl = HighLine.new

      def ask
        known_questions = methods.sort.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[:layout] = 'page'
          @answers[m.to_s.gsub(/^get_[0-9]{3}_/, '')] = method(m).call
        end
        @answers
      end

      # @!visibility private
      def initialize
        @answers = OpenStruct.new
        @hl = HighLine.new
      end

      def get_001_title
        hl = @hl
        title = hl.ask 'Title: '
        if hl.agree("Would you like it 'titleized' (Title instead of title)? ")
          title.titleize
        else
          title
        end
      end

      # @return [Array]
      def get_002_tags
        hl = @hl
        hl.ask("Tags? (write one on each line, then type '.') ") do |q|
          q.gather = '.'
        end
      end

      # @return [Array]
      def get_003_categories
        hl = @hl
        hl.ask("Categories? (write one on each line, then type '.') ") do |q|
          q.gather = '.'
        end
      end

      # @return [String]
      def get_004_time_zone
        hl = @hl
        custom = nil
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
        custom = hl.ask('Other Time Zone: ', String) if timezone == :neither
        return unless custom

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

      # @return [String]
      def get_005_file_format
        hl = @hl
        hl.choose do |menu|
          menu.header = 'Choose whether you want HTML or Markdown'
          menu.choice 'html' do
            return 'html'
          end
          menu.choice 'md' do
            return 'md'
          end
          menu.prompt = '? '
        end
      end
      # @return [String]
      def get_006_extra_fields
        hl = @hl
        custom_fields = nil
        if hl.agree('Do you want to add custom fields? (usable as {{LAYOUT_TYPE.FIELD}} in templates) ', true)
          hl.say('Your fields should be inputted as FIELD=>TEXT HERE')
          hl.say("Type 'EOL' on a new line then press Enter when you are done.")
          hl.say("<% HighLine.color('NOTE', :bold, :red) %>: Input is <% HighLine.color('NOT', :bold, :red) %> evaluated!")
          custom_fields = hl.ask('Fields?') do |q|
            q.gather = /^EOL$/
          end
        end
        if custom_fields
          fields = Hash.new
          custom_fields.each do |field|
            field = field.split(/=>/)
            fields.store(field[0].to_s, field[1])
          end
          self.extra_fields = fields
        elsif custom_fields.nil?
          hl.say('No extra fields were added.')
          return
        else
        end
        custom_fields
      end
      # @return [OpenStruct]
    end
  end
end

require 'yaml'
require 'active_support/all'
require 'highline'
module Mkmatter
  class Answers
    attr_accessor :title, :tags, :categories
    attr_accessor :date, :layout, :draft
    attr_accessor :slug_date, :answer_hash
    attr_accessor :published, :file_format
    attr_reader :matter
    
    def initialize(question_hash, publish)
      
      @layout      = question_hash[:layout]
      @title       = question_hash[:title]
      @tags        = question_hash[:tags]
      @categories  = question_hash[:categories]
      Time.zone    = question_hash[:time_zone]
      now          = Time.zone.now
      @date        = now.to_s
      @slug_date   = now.strftime('%Y-%m-%d')
      @published   = publish
      @file_format = question_hash[:file_format]
      @keywords = question_hash[:keywords]
      @description = question_hash[:description]
      @matter      = {
          layout:     @layout,
          title:      @title,
          categories: @categories,
          tags:       @tags,
          date:       @date,
      }
      @matter[:published] = @published if publish
    end
    
    # @return [Hash] returns attribute `.matter`
    def to_h
      @matter
    end
    
    # @param [Hash] hash other hash
    # @return [nil] merges hash into attribute `.matter`
    def to_h=(hash)
      @matter.merge!(hash)
    end
    
    alias_method :inspect, :to_h
    #
    # Dumps all file applicable metadata to a provided output.
    # @return [String] yaml front matter
    def dump
      custom_fields = nil
      hl            = HighLine.new($stdin, $stderr, 80)
      # Custom matter
      if hl.agree('Do you want to add custom fields? (usable as {{LAYOUT_TYPE.FIELD}} in templates) ', true)
        hl.say('Your fields should be inputted as FIELD=>TEXT HERE')
        hl.say("Enter 'EOL' on a new line and press enter when you are done.")
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
        self.to_h = fields
      elsif custom_fields.nil?
        hl.say('No extra fields were added.')
      else
      end
      self.to_h.stringify_keys.to_yaml(indentation: 2)
      '---'
    end
  end
end

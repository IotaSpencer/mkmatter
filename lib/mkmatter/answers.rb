require 'yaml'
require 'time'
require 'mkmatter/helpers'
module Mkmatter
  class Answers
    attr_accessor :title, :tags, :categories, :date, :draft, :slug_date, \
                  :answer_hash, :published, :file_format, :matter, :extra_fields, :summary

    def initialize(question_hash, publish, include_post_fields = true)
      @title        = question_hash[:title]
      @layout       = question_hash[:layout]
      if @layout == 'post'
        include_post_fields = true
      end
      @tags         = question_hash[:tags] if question_hash[:tags].nil? == false
      @categories   = question_hash[:categories] if question_hash[:categories].nil? == false
      Time.zone     =  get_time_zone_full(Time.now.getlocal) || 'Eastern Time (US & Canada)' if (include_post_fields == true || @layout == 'post')
      # Time.zone     = question_hash[:time_zone] || Time.now.zone
      @now           = Time.zone.now || Time.now.getlocal
      @date         = @now.to_s if include_post_fields == true
      @slug_date    = @now.strftime('%Y-%m-%d') if include_post_fields == true
      @published    = publish
      @file_format  = question_hash[:file_format]
      @extra_fields = question_hash[:extra_fields]
      if question_hash[:summary]
        @summary = question_hash[:summary] unless question_hash[:summary].empty?
      end

      @matter      = {
          layout:     @layout,
          title:      @title,
      }
      if @layout == 'post' or include_post_fields
        @matter[:tags] =       @tags if @tags
        @matter[:categories] = @categories if @categories
        @matter[:summary] =    @summary if @summary
        @matter[:date] =       @date 

      end
      if @draft
        @matter[:draft] = @draft
      end
      if @extra_fields
        @matter.merge!(@extra_fields)
      end
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
    def to_yaml(*args, **kwargs)
      @matter.stringify_keys.to_yaml(*args, **kwargs)
    end

  end
end

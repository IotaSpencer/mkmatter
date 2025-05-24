require 'yaml'
require 'active_support/all'
require 'highline'
module Mkmatter
  class Answers
    attr_accessor :title, :tags, :categories
    attr_accessor :date, :draft
    attr_accessor :slug_date, :answer_hash
    attr_accessor :published, :file_format
    attr_accessor :matter
    attr_accessor :extra_fields

    def initialize(question_hash, publish)
      @title       = question_hash[:title]
      @tags        = question_hash[:tags]
      @categories  = question_hash[:categories]
      Time.zone    = question_hash[:time_zone]
      now          = Time.zone.now
      @date        = now.to_s
      @slug_date   = now.strftime('%Y-%m-%d')
      @published   = publish
      @file_format = question_hash[:file_format]
      @extra_fields = question_hash[:extra_fields]

      @matter      = {
          layout:     question_hash[:layout],
          title:      @title,
          categories: @categories,
          tags:       @tags,
          date:       @date,
      }
      if @extra_fields
        @matter.merge!(@extra_fields)
      end
      @matter[:published] = @published if publish
    end

  end
end

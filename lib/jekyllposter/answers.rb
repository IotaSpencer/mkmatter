require 'ostruct'
require 'yaml'
require 'active_support/core_ext/hash'

module Jekyllposter
  class Answers
    attr_accessor :submission_type
    attr_accessor :title, :tags, :categories, :file_string
    attr_accessor :date_string, :dt_string, :layout, :file_type
    attr_accessor :slug, :answer_hash
    attr_reader :draft, :layout

    def initialize(submission_type, submission_layout, question_hash)
      @answer_hash = OpenStruct.new
      @type = submission_type
      case submission_type
      when :draft
        @draft = true
      else
        @draft = false
      end
      @layout = submission_layout
      case submission_layout
      when :page
        @answer_hash['layout'] = 'page'
      when :post
        @answer_hash['layout'] = 'post'
      end
      @answer_hash['title'] = question_hash[:title]
      @tags = nil
      @categories = nil
      @date_string = nil
      @dt_string = nil
      @file_type = nil
      @slug = nil
    end

    def dump(path_or_file, stdout = true)
      if path_or_file.nil?
        raise ArgumentError
      end
      if path_or_file.is_a? String
        path_or_file = File.expand_path(path)

        File.open(path_or_file, 'a') do |fd|
          fd.puts @answer_hash.to_yaml
          fd.puts "---"
        end
      elsif path_or_file.is_a? FalseClass and stdout == true
        puts @answer_hash.to_h.stringify_keys.to_yaml
        puts "---"
      end
    end
  end
end

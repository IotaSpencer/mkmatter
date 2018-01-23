require 'highline'
require 'jekyllposter/common'
require 'jekyllposter/markdown'
require 'ostruct'
module Jekyllposter
  module Questions

    class Post
      include Jekyllposter::Common

      attr :answers
      attr :highline_context

      # @param [HighLine] highline_context a highline context
      def initialize(highline_context)
        @highline_context = highline_context
        @answers = OpenStruct.new
      end

      def ask
        known_questions = self.methods.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[m.to_s.gsub(/^get_/, '')] = self.method(m).call(@highline_context)
        end
        @answers
      end
    end

    class Page
      include Jekyllposter::Common
      attr :answers
      attr :highline_context
      def initialize(highline_context)
        @answers = OpenStruct.new
        @highline_context = highline_context
      end

      def ask
        known_questions = self.methods.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.sort!
        known_questions.each do |m|
          @answers[m.to_s.gsub(/^get_/, '')] = self.method(m).call(@highline_context)
        end
        @answers
      end
    end
  end
end

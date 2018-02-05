require 'highline'
require 'mkmatter/common'
require 'ostruct'
module Mkmatter
  module Questions

    class Post
      include Mkmatter::Common

      attr :answers
      attr :highline_context
      
      # @!visibility private
      # @param [HighLine] highline_context a highline context
      def initialize(highline_context)
        @highline_context = highline_context
        @answers = OpenStruct.new
      end

      # @return [OpenStruct]
      def ask
        known_questions = self.methods.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[m.to_s.gsub(/^get_/, '')] = self.method(m).call(@highline_context)
        end
        @answers
      end
    end

    class Page
      include Mkmatter::Common
      attr :answers
      attr :highline_context
      
      
      # @!visibility private
      def initialize(highline_context)
        @answers = OpenStruct.new
        @highline_context = highline_context
      end
      
      # @return [OpenStruct]
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

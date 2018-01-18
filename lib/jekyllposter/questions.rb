require 'highline'
require 'jekyllposter/common'

module Jekyllposter
  module Questions
    HL = HighLine.new

    class Post
      include Jekyllposter::Common

      attr :published
      attr :answers

      def initialize
        @published = nil
        @answers = OpenStruct.new
      end

      def ask
        known_questions = self.methods.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[m.to_s.gsub(/^get_/, '')] = self.method(m).call(HL)
        end
        @answers
      end
    end

    class Page
      include Jekyllposter::Common
      attr :published, :answers

      def initialize
        @published = nil
        @answers = OpenStruct.new
      end

      def ask
        known_questions = self.methods.delete_if { |m| m.to_s !~ /^get_.*$/ }
        known_questions.each do |m|
          @answers[m.to_s.gsub(/^get_/, '')] = self.method(m).call(HL)
        end
        @answers
      end
    end
  end
end

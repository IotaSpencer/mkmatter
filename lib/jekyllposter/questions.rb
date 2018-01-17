require 'highline'
require 'jekyllposter/common'

module Jekyllposter
  module Questions
    HL = HighLine.new

    class Post
      include Jekyllposter::Common

      attr :published

      def initialize
        @published = nil
      end

      def ask
      end
    end

    class Page
      include Jekyllposter::Common

      def initialize
      end
    end

    class Draft
      include Jekyllposter::Common

      def initialize
      end
    end
  end
end

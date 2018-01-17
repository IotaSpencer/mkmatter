require 'highline'

module Jekyllposter
  module Common
    attr :highline
    attr :title, :tags, :categories

    def initialize
      @title = nil
      @hl = HighLine.new
    end

    def get_title
      return @hl.ask "Title: "
    end

    def get_tags
      return @hl.ask("Tags?  (comma separated list)  ", -> (str) { str.split(/,\s*/) })
    end

    def get_categories
      return @hl.ask("Categories? (comma separated list)  ", -> (str) { str.split(/,\s*/) })
    end
  end
end

require 'highline'

module Questions
  class Common
    attr :highline
    attr :title

    def initialize
      @title = nil
      @hl = HighLine.new
    end

    def get_title
      return @hl.ask "Title: "
    end
  end
end

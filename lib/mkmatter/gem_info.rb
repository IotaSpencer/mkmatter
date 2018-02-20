require 'rubygems'
module Mkmatter
  GEM_NAME = 'mkmatter'
  NAME     = GEM_NAME
  
  #
  # Gem Description
  DESC = %q{A gem helps a user maintain a jekyll site source directory.}
  
  #
  # Gem Summary
  SUMMARY = %q{Script facilitating easy content creation and generation for Jekyll Sites}
  
  #
  # Gem Version
  
  class GemInfo
    #
    # Gem Name
    
    
    def initialize
      @gem = Gem::Specification.find_by_name(GEM_NAME)
    end
    
    def attrs
      @gem
    end
  end
end
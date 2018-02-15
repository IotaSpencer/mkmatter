require 'rubygems'
require 'json'
require 'yaml'
module Mkmatter
  GEM_NAME = 'mkmatter'
  NAME     = GEM_NAME
  
  #
  # Gem Description
  DESC = %q{A gem that prompts users through setting up a Jekyll page, post.}
  
  #
  # Gem Summary
  SUMMARY = %q{Script facilitating easy content creation in Jekyll}
  
  #
  # Gem Version
  VERSION = '3.0.1'
  class GemInfo
    #
    # Gem Name

    
    def initialize
      @gem  = Gem::Specification.find_by_name(GEM_NAME)
    end
    def attrs
      @gem
    end
  end
end

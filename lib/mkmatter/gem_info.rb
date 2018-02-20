require 'mkmatter/version'
module Mkmatter
  # Gem Name
  GEM_NAME = 'mkmatter'
  # Gem Name Alias
  NAME     = GEM_NAME
  
  #
  # Gem Description
  DESC = %q{A gem helps a user maintain a jekyll site source directory.}
  
  #
  # Gem Summary
  SUMMARY = %q{Script facilitating easy content creation and generation for Jekyll Sites}
  # Return gem information for certain commands and options
  class GemInfo
    # @return [Array] list of authors
    def GemInfo.authors
      ['Ken Spencer']
    end
    
    # @return [Array] authors emails
    def GemInfo.email
      ['me@iotaspencer.me']
    end
  end
end
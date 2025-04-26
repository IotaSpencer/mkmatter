module Mkmatter
  VERSION = '3.1.6'

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
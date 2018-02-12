require 'highline'
module Mkmatter
  class Methods
    
    attr :file_path, :hl, :questions, :answers
    
    def initialize(answers = nil)
      @questions = nil
      @answers   = answers if answers != nil
      @hl        = HighLine.new($stdin, $stderr, 80)
    end
    
    def check_if_jekyll
      cwd = Pathname.new('.')
      if cwd.join('index.html').exist?
        if cwd.join('_posts').exist? or cwd.join('_layouts').exist?
          true
        elsif cwd.join('_posts').exist? and cwd.join('_layouts').exist?
          true
        else
          @hl.say("<%= color('Warning', :orange, :bold) %>: _posts and/or _layouts directories do not exist. <%= color('This script may not work correctly.', :bold) %>")
          true
        end
      else
        @hl.say("<%= color('Error', :red, :bold) %>: The current directory is presumably not a jekyll site directory. This is due to it not containing an 'index.html' file, or otherwise preferably '_posts' and/or '_layouts' directories.")
        @hl.say('<%= color(\'Exiting...\', :red, :bold) %>')
        false
      end
    end
    
    def launch_editor
      if @hl.agree("Would you like to open an editor? ('editor' command) ", true)
        pid = spawn("editor #{@file_path}")
        Process.wait pid
      
      end
    end
    
    def and_again
      again = @hl.agree 'Would you like to do another?', true
      case again
        when true
          self.run
        else
          @hl.say 'Alright, Thanks!'
          exit 0
      end
    end
    
    def Methods.run
      self.launch_editor
      self.and_again
    end
  end
end
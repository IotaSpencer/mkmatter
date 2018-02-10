require 'thor/group'
require 'highline'
module Mkmatter
  class Methods
    
    attr :file_path, :hl, :questions, :answers
    @questions = nil
    @hl        = HighLine.new($stdin, $stderr, 80)
    @answers   = nil
    
    def Methods.run
      Methods.main
      Methods.put_in_folder
      Methods.launch_editor
      Methods.and_again
    end
    
    def Methods.main
      draft  = @hl.agree 'Is this a draft post/page? ', true
      layout = @hl.choose do |menu|
        menu.header = 'Layout'
        menu.choice :post
        menu.choice :page
        menu.prompt  = '? '
        menu.default = :post
      end
      case layout
        when :post
          @questions = Mkmatter::Questions::Post.new(@hl).ask
        when :page
          @questions = Mkmatter::Questions::Page.new(@hl).ask
      end
      @answers = Mkmatter::Answers.new(draft, layout, @questions)
      
      @stdout = @hl.agree 'Would you like to output to stdout?', true
    
    end
    
    
    def Methods.put_in_folder
      file_date  = @answers.slug_date
      file_title = @answers.title.to_slug
      file_ext   = @answers.file_format
      case @answers.draft
        when true
          type_folder = '_drafts'
        else
          case @answers.layout
            when 'post'
              type_folder = "_#{@answers.layout}s"
            when 'page'
          end
      end
      if @stdout
        @answers.dump(false, true)
      end
      unless @stdout
        catch [:no_file, :not_writable, :restart] do
          case @answers.layout
            when 'post'
              return unless @hl.agree('Would you like this script to write the file in the folder? ', true)
              folder = nil
              if @hl.agree("Is your jekyll site source folder somewhere inside the current working directory ( #{Dir.getwd} )? ", true)
                folder      = @hl.ask('Select your folder (relative path) ', String)
                path_folder = Pathname(folder)
                return unless path_folder.relative?
                
                folder = path_folder
              else
                folder      = @hl.ask("What's the absolute path of your jekyll root? (make sure the user account has permissions) ", String)
                path_folder = Pathname(folder)
                return if path_folder.relative?
                
                folder = path_folder
              
              end
              folder_path = nil
              begin
                folder_path = folder.realpath
              rescue Errno::ENOENT
                @hl.say("#{color('Error', :bold, :red)}: '#{folder}' does not exist.")
                if @hl.agree('Try again? (exits otherwise)', true)
                  return
                else
                  $stderr.puts 'Exiting!'
                  exit 0
                end
              end
              file       = @hl.ask("What file path? (accept '.' as default to use YYYY-MM-DD-#{@answers.title.to_slug}) ", String) do |q|
                q.default = '.'
              end
              dir_path   = File.join(folder_path.expand_path.to_s, type_folder)
              @file_path = File.join(folder_path.expand_path.to_s, type_folder, "#{file_date}-#{file_title}.#{file_ext}")
              
              case file
                when '.'
                  if File.writable? dir_path
                    @answers.dump(@file_path, @stdout)
                  else
                    @hl.say "<% color('Error', :red, :bold) %>:#{dir_path} exists but is not writable!"
                    if @hl.agree('Continue? ', true)
                      @hl.say('Lets try again')
                      throw :not_writable
                    end
                  end
                
                else
                  @answers.dump(@file_path, @stdout)
              end
            when 'page'
              return unless @hl.agree('Would you like this script to write the file in the folder? ', true)
              if @hl.agree("Is your jekyll site source folder somewhere inside the current working directory ('#{Dir.getwd}')? ", true)
                folder      = @hl.ask('Select your folder (relative path) ', String)
                path_folder = Pathname(folder)
                throw :restart unless path_folder.relative?
                
                folder = path_folder
              else
                folder      = @hl.ask("What's the absolute path of your jekyll root? (make sure the user account has permissions) ", String)
                path_folder = Pathname(folder)
                throw :restart if path_folder.relative?
                
                folder = path_folder
              
              end
              folder_path = nil
              begin
                folder_path = folder.realpath
              rescue Errno::ENOENT
                @hl.say("#{color('Error', :bold, :red)}: '#{folder}' does not exist.")
                if @hl.agree('Try again? (exits otherwise)', true)
                  throw :no_file
                else
                  $stderr.puts 'Exiting!'
                  exit 0
                end
              end
              file     = @hl.ask("What file path? (accept '.' as default to use #{@answers.title.to_slug}) ", String) do |q|
                q.default = '.'
              end
              dir_path = File.join(folder_path.expand_path.to_s)
              case @hl.agree("Is this going to be a 'index' of a folder? ", true)
                when true
                  @file_path = File.join(folder_path.expand_path.to_s, "index.#{file_ext}")
                when false
                  @file_path = File.join(folder_path.expand_path.to_s, "#{file_title}.#{file_ext}")
              end
              case file
                when '.'
                  if File.writable? dir_path
                    @answers.dump(@file_path, @stdout)
                  else
                    @hl.say "<% color('Error', :red, :bold) %>:#{dir_path} exists but is not writable!"
                    if @hl.agree('Continue? ', true)
                      @hl.say('Lets try again')
                      throw :not_writable
                    end
                  end
                
                else
                  @answers.dump(@file_path, @stdout)
              end
          end
        end
      end
    end
    
    def Methods.launch_editor
      if @hl.agree("Would you like to open an editor? ('editor' command) ", true)
        pid = spawn("editor #{@file_path}")
        Process.wait pid
      
      end
    end
    
    def Methods.and_again
      again = @hl.agree 'Would you like to do another?', true
      case again
        when true
          self.run
        else
          @hl.say 'Alright, Thanks!'
          exit 0
      end
    end
  end
end
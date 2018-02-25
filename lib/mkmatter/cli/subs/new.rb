require 'highline'
require 'thor'

require 'mkmatter/cli/descriptions'
require 'mkmatter/cli/methods'
require 'mkmatter/questions'
require 'mkmatter/answers'
module Mkmatter
  module App
    module Classes
      # Generate 'New' Content
      class NewContent < Thor
        include Thor::Actions
        HILINE = HighLine.new($stdin, $stderr, 40)
        option :publish, :type => :boolean
        option :file, :type => :boolean
        desc 'page [options]', 'make front matter (and possibly content) for a jekyll page'
        long_desc Mkmatter::App::Descriptions::New::PAGE
    
        def page
          if options[:file]
            if Mkmatter::Methods.check_if_jekyll
              @questions = Mkmatter::Questions::Page.new(HILINE).ask
              answers    = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
              filename   = answers.title.to_slug + '.' + answers.file_format.downcase
              path       = Pathname("./#{filename}").realdirpath
              if HILINE.agree('Would you like to put this page into a subdirectory?', true)
                HILINE.say("What path? (directories will be created if they don't exist) ")
                HILINE.say("Don't use a path starting with a slash, just put a relative path.")
                HILINE.say('good => path/to/dir ‖ bad => /root/paths/are/bad/mmkay')
                folder = HILINE.ask('? ') do |q|
                  q.confirm  = true
                  q.default  = '.'
                  q.validate = /^[^\/].*$/
                end
                folder = Pathname(folder)
                begin
                  FileUtils.mkdir_p(File.join(Mkmatter::Methods.get_jekyll_root, folder))
                rescue Errno::EEXIST
                  HILINE.say("<%= color('Error', :red, :bold) %>:Insufficient Permissions")
                  exit 1
                end
                path = Pathname(folder).realdirpath.join(filename)
              end
              File.open(path.to_path, 'a') do |fd|
                fd.puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
                fd.puts '---'
              end
              Mkmatter::Methods.launch_editor(path)
            else
              puts "Not in a Jekyll directory. (no '_config.yml' in any parent directory)"
              exit 1
            end
          else
            answers = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
            puts ''
            puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
            puts '---'
          end
        end
    
    
        option :publish, :type => :boolean
        option :file, :type => :boolean
        option :draft, :type => :boolean
        desc 'post [options]', 'make front matter (and possibly content) for a jekyll post'
        long_desc Mkmatter::App::Descriptions::New::POST
    
        def post
      
          if options[:draft] and options[:file]
        
            if Mkmatter::Methods.check_if_jekyll
              @questions  = Mkmatter::Questions::Post.new(HILINE).ask
              answers     = Mkmatter::Answers.new(@questions, options[:publish])
              file_folder = '_drafts'
              filename    = [].concat([answers.slug_date, '-', answers.title.to_slug, '.', answers.file_format.downcase]).join
          
              path = Pathname("./#{file_folder}/#{filename}").realdirpath
              if HILINE.agree('Would you like to put this page into a subdirectory?', true)
                HILINE.say("What path? (directories will be created if they don't exist)")
                HILINE.say("Don't use a path starting with a slash, just put a relative path.")
                HILINE.say('<%= color(\'Good\', :green, :bold) %>: path/to/dir ‖ <%= color(\'Bad\', :red, :bold) %>: /root/paths/are/bad/mmkay')
                folder = HILINE.ask('? ') do |q|
                  q.confirm  = true
                  q.default  = '.'
                  q.validate = /^[^\/].*$/
                end
                folder = Pathname(folder)
                begin
                  FileUtils.mkdir_p(File.join(Mkmatter::Methods.get_jekyll_root, folder))
                rescue Errno::EEXIST
                  HILINE.say("<%= color('Error', :red, :bold) %>:Insufficient Permissions")
                  exit 1
                end
                path = Pathname(folder).realdirpath.join(filename)
              end
              File.open(path.to_path, 'a') do |fd|
                fd.puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
                fd.puts '---'
              end
              Mkmatter::Methods.launch_editor(path)
            else
              puts "Not in a Jekyll directory. (no '_config.yml' in any parent directory)"
              exit 1
            end
          elsif options[:file] and options[:draft].nil? or options[:draft] == false
        
            if Mkmatter::Methods.check_if_jekyll
              @questions  = Mkmatter::Questions::Post.new(HILINE).ask
              answers     = Mkmatter::Answers.new(@questions, options[:publish])
              file_folder = '_posts'
              filename    = [].concat([answers.slug_date, '-', answers.title.to_slug, '.', answers.file_format.downcase]).join('')
              path        = Pathname("./#{file_folder}/#{filename}").realdirpath
              if HILINE.agree('Would you like to put this post into a subdirectory?', true)
                HILINE.say('What path?')
                HILINE.say('----------------')
                HILINE.say("Don't use a path starting with a slash, just put a relative path.")
                HILINE.say("If you enter a path you don't like, you will have manually remove it if you confirm it.")
                HILINE.say('<%= color(\'Good\', :green, :bold) %>: path/to/dir ‖ <%= color(\'Bad\', :red, :bold) %>: /root/paths/are/bad/mmkay')
                folder = HILINE.ask('? ') do |q|
                  q.confirm  = true
                  q.default  = '.'
                  q.validate = /^[^\/].*$/
                end
                folder = Pathname("#{file_folder}/#{folder}")
                begin
                  FileUtils.mkdir_p(File.join(Mkmatter::Methods.get_jekyll_root, folder))
                rescue Errno::EEXIST
                  HILINE.say("<%= color('Error', :red, :bold) %>:Insufficient Permissions")
                  exit 1
                end
                path = Pathname(folder).realdirpath.join(filename)
              end
              File.open(path.to_path, 'a') do |fd|
                fd.puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
                fd.puts '---'
              end
          
              Mkmatter::Methods.launch_editor(path)
            else
              puts "Not in a Jekyll directory. (no '_config.yml' in any parent directory)"
              exit 1
            end
          elsif options[:draft].nil? and options[:file].nil?
            @questions = Mkmatter::Questions::Post.new(HILINE).ask
            answers    = Mkmatter::Answers.new(@questions, options[:publish])
            puts ''
            puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
            puts '---'
      
          end
        end
      end
    end
  end
end
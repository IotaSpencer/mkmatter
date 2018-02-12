require 'thor'
require 'mkmatter/cli/methods'
require 'mkmatter/questions'
require 'methods'
require 'highline'
require 'slugity/extend_string'
require 'yaml'
require 'active_support/all'
module Mkmatter
  
  module App
    
    
    class CLI < Thor
      include Thor::Actions
      HILINE = HighLine.new($stdin, $stderr, 80)
      map %w[--version -v] => :__print_version
      
      desc '--version, -v', 'print the version'
      
      def __print_version
        puts Mkmatter::VERSION
      end
      
      
      option :publish, :type => :boolean, :desc => 'Whether to publish the post/page'
      option :file, :type => :boolean, :desc => '--file to output to a TITLESLUG.FORMAT named file, else output to stdout'
      desc 'page ...ARGS', 'make front matter (and possibly content) for a jekyll page'
      
      def page
        meths = Mkmatter::Methods.new
        if meths.check_if_jekyll
          @questions = Mkmatter::Questions::Page.new(HighLine.new($stdin, $stderr, 80)).ask
          if options[:file]
            answers  = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
            filename = answers.title.to_slug + '.' + answers.file_format.downcase
            path     = Pathname("./#{filename}").realdirpath
            if HILINE.agree('Would you like to put this page into a subdirectory?', true)
              HILINE.say("What path? (directories will be created if they don't exist) ")
              HILINE.say("Don't use a path starting with a slash, just put a relative path.")
              HILINE.say('Good => path/to/dir / Bad => /root/paths/are/bad/mmkay')
              folder = HILINE.ask('? ') do |q|
                q.confirm = true
                q.default = '.'
              end
              path   = Pathname(folder).realdirpath.join(filename)
            end
            File.open(path.to_path, 'a') do |fd|
              fd.puts self.to_h.stringify_keys.to_yaml(indentation: 2)
              fd.puts '---'
            end
          else
            answers = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
            
            puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
            puts '---'
          end
        
        end
      end
      
      
      option :file, :type => :boolean, :desc => '--no-file or omit for STDOUT or --file to output to a DATE-TITLE-SLUG.FORMAT named file.'
      option :draft, :type => :boolean, :desc => 'Mark the page or post as a draft'
      desc 'post ...ARGS', 'make front matter (and possibly content) for a jekyll post'
      
      def post
        meths = Mkmatter::Methods.new
        if meths.check_if_jekyll
          @questions = Mkmatter::Questions::Post.new(HighLine.new($stdin, $stderr, 80)).ask
          if options[:draft] and options[:file]
            file_folder = '_drafts'
          
          elsif options[:file] and options[:draft].is_a? FalseClass
            file_folder = '_posts'
          
          else
          end
        end
      end
    end
  end
end
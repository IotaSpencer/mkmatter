require 'thor'
require 'mkmatter/cli/methods'
require 'mkmatter/questions'
require 'methods'
require 'highline'
require 'slugity/extend_string'
require 'yaml'
require 'active_support/all'
require 'terminal-table'
require 'os'
module Mkmatter
  module App
    class CLI < Thor
      include Thor::Actions
      HILINE = HighLine.new($stdin, $stderr, 80)
      map %w[--version -v] => :__print_version
      desc '--version, -v', 'Print the version'
      
      def __print_version
        puts Mkmatter::VERSION
      end
      
      map %w[--debug -d] => :__debug
      desc '--debug, -i', 'Prints debug info about the script/gem'
      
      def __debug
        info = Mkmatter::GemInfo.new
        report = YAML.safe_load(OS.report)
        rows = {
            'mkmatter_version' => info.attrs.version.to_s,
            'rubygems_version' => info.attrs.rubygems_version,
            'platform'         => info.attrs.platform
        }
        rows.merge! report
        rows.merge!({
          'ruby_bin' => OS.ruby_bin,
          'windows'  => OS.windows?,
          'posix'    => OS.posix?,
          'mac'      => OS.mac?,
          'under windows' => OS::Underlying.windows?,
          'under bsd'     => OS::Underlying.bsd?
        })
        table                  = Terminal::Table.new
        table.style.width      = 60
        table.style.border_top = false
        table.title            = 'mkmatter Debug Info'
        table.rows             = rows.to_a
        table.align_column(0, :left)
        width = table.style.width - 2
        print '+', '-' * width, '+'
        puts
        puts table
        puts
      end
      
      map %w[--info -v] => :__print_info
      desc '--info, -i', 'Print script/gem info'
      
      def __print_info
        format = options[:'info-format']
        info   = Mkmatter::GemInfo.new
        rows   = {
            'Author(s)':        info.attrs.authors.join(', '),
            'E-Mail':           info.attrs.email,
            'mkmatter-Version': info.attrs.version.to_s,
            'RubyGems-Version': info.attrs.rubygems_version,
            'Platform':         info.attrs.platform
        }
        case format
          when 'table'
            table                  = Terminal::Table.new
            table.style.width      = 60
            table.style.border_top = false
            table.style.alignment  = :center
            table.title            = 'mkmatter Info'
            table.rows             = rows.to_a
            table.align_column(0, :left)
            width = table.style.width - 2
            print '+', '-' * width, '+'
            puts
            puts table
            puts
          when 'yaml'
            puts rows.stringify_keys.to_yaml
          
          else
            # noop
            # this doesn't get run because of
            # the logic of options and their
            # enum parameter.
        end
      end
      
      class_option :'info-format', :type => :string, desc: 'The format of info', enum: %w(table yaml), default: 'table'
      class_option :publish, :type => :boolean, :desc => "Whether to publish the post/page, omit to disable 'published: true/false' from showing in yaml"
      option :file, :type => :boolean, :desc => '--file to output to a TITLESLUG.FORMAT named file, else output to stdout'
      desc 'page ...ARGS', 'make front matter (and possibly content) for a jekyll page'
      
      def page
        if Mkmatter::Methods.new.check_if_jekyll
          catch :restart do
            @questions = Mkmatter::Questions::Page.new(HighLine.new($stdin, $stderr, 80)).ask
            if options[:file]
              answers  = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
              filename = answers.title.to_slug + '.' + answers.file_format.downcase
              path     = Pathname("./#{filename}").realdirpath
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
              meths = Mkmatter::Methods.new(answers, path.to_path)
              meths.launch_editor
              if HILINE.agree('Would you like to do another?', true)
                throw :restart
              else
                exit 0
              end
            else
              answers = Mkmatter::Answers.new(@questions, options.fetch(:publish, nil))
              puts ''
              puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
              puts '---'
              meths = Mkmatter::Methods.new(answers, nil)
              if HILINE.agree('Would you like to do another?', true)
                throw :restart
              else
                exit 0
              end
            end
          end
        end
      end
      
      
      option :file, :type => :boolean, :desc => '--no-file or omit for STDOUT or --file to output to a DATE-TITLE-SLUG.FORMAT named file.'
      option :draft, :type => :boolean, :desc => 'Mark the page or post as a draft'
      desc 'post ...ARGS', 'make front matter (and possibly content) for a jekyll post'
      
      def post
        meths = Mkmatter::Methods.new
        if meths.check_if_jekyll
          catch :restart do
            @questions = Mkmatter::Questions::Post.new(HighLine.new($stdin, $stderr, 80)).ask
            if options[:draft] and options[:file]
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
              meths = Mkmatter::Methods.new(answers, path.to_path)
              meths.launch_editor
              if HILINE.agree('Would you like to do another?', true)
                throw :restart
              else
                exit 0
              end
            elsif options[:file] and options[:draft].nil?
              answers     = Mkmatter::Answers.new(@questions, options[:publish])
              file_folder = '_posts'
              filename    = [].concat([answers.slug_date, '-', answers.mktitle.to_slug, '.', answers.file_format.downcase]).join('')
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
              meths = Mkmatter::Methods.new(answers, path.to_path)
              meths.launch_editor
              if HILINE.agree('Would you like to do another?', true)
                throw :restart
              else
                exit 0
              end
            
            elsif options[:draft].nil? and options[:file].nil?
              answers = Mkmatter::Answers.new(@questions, options[:publish])
              puts ''
              puts answers.to_h.stringify_keys.to_yaml(indentation: 2)
              puts '---'
              meths = Mkmatter::Methods.new(answers, nil)
              if HILINE.agree('Would you like to do another?', true)
                throw :restart
              else
                exit 0
              end
            end
          end
        end
      end
    end
  end
end
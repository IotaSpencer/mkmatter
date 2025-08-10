require "thor"
require "highline"
require "slugity/extend_string"
require "yaml"
require "active_support/all"
require "terminal-table"
require "os"
require "rbconfig"
require "mkmatter/version"
require "mkmatter/cli/subs"
require 'mkmatter/cli/descriptions'

module Mkmatter
  module App
    class CLI < Thor
      # \(see {http://www.rubydoc.info/gems/highline/HighLine#initialize-instance_method HighLine#new}\)
      
      map %w[--version -v] => :__print_version
      desc "--version, -v", "Print the version"
      package_name "mkmatter"

      # Prints version string
      # @return [NilClass] nil
      def __print_version
        puts Mkmatter::VERSION
      end

      map %w[--debug -d] => :__debug
      desc "--debug, -d", "Prints debug info about the script/gem"
      # Prints debug info
      # @return [NilClass] returns nil
      def __debug
        report = YAML.safe_load(OS.report)
        rows = {
          :mkmatter_version => Mkmatter::VERSION,
          :ruby_version => RbConfig::CONFIG["RUBY_PROGRAM_VERSION"],
        }
        rows.merge! report
        rows.merge!({
                      "ruby bin" => OS.ruby_bin,
                      :windows => OS.windows?,
                      :posix => OS.posix?,
                      :mac => OS.mac?,
                      "under windows" => OS::Underlying.windows?,
                      "under bsd" => OS::Underlying.bsd?,
                    })
        table = ::Terminal::Table.new
        table.title = "mkmatter Debug Info"
        table.rows = rows.to_a
        table.align_column(0, :left)

        puts table
      end

      map %w[--info -i] => :__print_info
      desc "--info, -i", "Print script/gem info"
      method_option :'info-format', :type => :string, desc: "The format of info", enum: %w(table yaml), default: "table"
      # @return [NilClass] Prints Gem info
      def __print_info
        format = options[:'info-format']
        rows = {
          'author(s)': Mkmatter::GemInfo.authors.join(", "),
          'e-mail': Mkmatter::GemInfo.email.join(", "),
          'mkmatter version': Mkmatter::VERSION,
          'Ruby version': RbConfig::CONFIG["RUBY_PROGRAM_VERSION"],
          'Platform': RbConfig::CONFIG["build_os"],
        }
        case format
        when "table"
          table = ::Terminal::Table.new
          table.style.alignment = :center
          table.title = "mkmatter Info"
          table.rows = rows.to_a
          table.align_column(0, :left)

          puts table
        when "yaml"
          puts rows.stringify_keys.to_yaml
        else
          # noop
          # this doesn't get run because of
          # the logic of options and their
          # enum parameter.
        end
      end

      option :index, :type => :boolean, :default => nil
      option :type, :type => :string, :default => "post"
      option :'include-post-qs', :type => :boolean, :default => false,
        desc: "Include post questions in the prompt"
      option :'dry-run', :type => :boolean, :default => false
      desc "new [options]", "make front matter (and possibly content) for a jekyll site"
      long_desc Mkmatter::App::Descriptions::New::NEW
      def new
        # @questions = Mkmatter::Questions::Post.new(HILINE).ask
        @questions = Mkmatter::Questions.new.ask(options[:type], options[:include_post_qs])
        answers = Mkmatter::Answers.new(@questions, options[:publish], options[:include_post_qs])
        draft_folder = "_drafts"
        filename = [].concat([answers.slug_date, "-", answers.title.to_slug, ".", answers.file_format.downcase]).join

        path = Pathname("./#{filename}").realdirpath
        if HILINE.agree("Would you like to put this page into a subdirectory? ", true)
          HILINE.say(<<~FOLDERDOC)
            What path? (directories will be created if they don't exist, relative to Jekyll root)
            
          FOLDERDOC
          folder = HILINE.ask("? ") do |q|
            q.confirm = true
            q.default = "."
            q.validate = /^[^\/].*$/
            q.responses[:not_valid] = "Please enter a valid path, a relative path from the Jekyll root."
            q.responses[:ask_on_error] = :question
          end
          folder = Pathname(folder)
          if options[:'dry-run']
            HILINE.say("Would create #{File.join(Pathname("."), folder)}")
          else
            begin
              FileUtils.mkdir_p(File.join(Mkmatter::Methods.get_jekyll_root, folder))
            rescue Errno::EEXIST
              HILINE.say("<%= color('Error', :red, :bold) %>:Insufficient Permissions")
              exit 1
            end
          end
          if options[:'dry-run']
            # If dry-run, don't check for the folder
            # and just use the folder as is.
            path = Pathname(folder).join(filename)
          else
            # Otherwise, check for the folder
            path = Pathname(folder).realdirpath.join(filename)
          end
        end
        if options[:'dry-run']
          HILINE.say("Would create '#{path}'")
          HILINE.say("Would output \n#{answers.to_yaml(indentation: 2)}\n---\n\n")
        else
          File.open(path.to_path, "a") do |fd|
            fd.puts answers.to_yaml(indentation: 2)
            fd.puts "---"
          end
          Mkmatter::Methods.launch_editor(options[:editor], path)
        end
      end

      desc "tags SUBCOMMAND [options]", "Generate or Create tags"
      subcommand "tags", Mkmatter::App::Classes::Tags
    end
  end
end

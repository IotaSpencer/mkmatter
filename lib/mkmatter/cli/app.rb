require 'thor'
require 'highline'
require 'slugity/extend_string'
require 'yaml'
require 'active_support/all'
require 'terminal-table'
require 'os'
require 'rbconfig'

require 'mkmatter'
require 'mkmatter/cli/subs'
module Mkmatter
  module App
    class CLI < Thor
      include Thor::Actions
      HILINE = HighLine.new($stdin, $stderr, 80)
      map %w[--version -v] => :__print_version
      desc '--version, -v', 'Print the version'
      
      # Prints version string
      def __print_version
        puts Mkmatter::VERSION
      end
      
      map %w[--debug -d] => :__debug
      desc '--debug, -d', 'Prints debug info about the script/gem'
      # Prints debug info
      def __debug
        info   = Mkmatter::GemInfo.new
        report = YAML.safe_load(OS.report)
        rows   = {
            'mkmatter_version' => Mkmatter::VERSION,
            'ruby_version' => RbConfig::RUBY_VERSION,
            'platform'         => RbConfig::RUBY_PLATFORM
        }
        rows.merge! report
        rows.merge!({
                        'ruby_bin'      => OS.ruby_bin,
                        'windows'       => OS.windows?,
                        'posix'         => OS.posix?,
                        'mac'           => OS.mac?,
                        'under windows' => OS::Underlying.windows?,
                        'under bsd'     => OS::Underlying.bsd?
                    })
        table                  = Terminal::Table.new
        table.style.width      = 80
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
      
      map %w[--info -i] => :__print_info
      desc '--info, -i', 'Print script/gem info'
      method_option :'info-format', :type => :string, desc: 'The format of info', enum: %w(table yaml), default: 'table'
      def __print_info
        format = options[:'info-format']
        rows   = {
            'Author(s)':        Mkmatter::GemInfo.authors,
            'E-Mail':           Mkmatter::GemInfo.email,
            'mkmatter-Version': Mkmatter::VERSION,
            'RubyGems-Version': RbConfig::RUBY_VERSION,
            'Platform':         RbConfig::RUBY_PLATFORM
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
      
      desc 'new SUBCOMMAND [options]', 'Make new content'
      subcommand 'new', Mkmatter::App::Classes::NewContent
      desc 'tags SUBCOMMAND [options]', 'Generate or Create tags'
      subcommand 'tags', Mkmatter::App::Classes::Tags
    end
      
    
  end
end
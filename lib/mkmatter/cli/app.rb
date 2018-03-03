require 'thor'
require 'highline'
require 'slugity/extend_string'
require 'yaml'
require 'active_support/all'
require 'terminal-table'
require 'os'
require 'rbconfig'

require 'mkmatter/cli/subs'
require 'mkmatter/gem_info'

module Mkmatter
  module App
    class CLI < Thor
      # \(see {http://www.rubydoc.info/gems/highline/HighLine#initialize-instance_method HighLine#new}\)
      HILINE = HighLine.new($stdin, $stderr, 80)
      map %w[--version -v] => :__print_version
      desc '--version, -v', 'Print the version'
      
      # Prints version string
      # @return [NilClass] nil
      def __print_version
        puts Mkmatter::VERSION
      end
      
      map %w[--debug -d] => :__debug
      desc '--debug, -d', 'Prints debug info about the script/gem'
      # Prints debug info
      # @return [NilClass] returns nil
      def __debug
        report = YAML.safe_load(OS.report)
        rows   = {
            'mkmatter_version' => Mkmatter::VERSION,
            'ruby_version'     => RbConfig::CONFIG['RUBY_PROGRAM_VERSION'],
        }
        rows.merge! report
        rows.merge!({
                        'ruby_bin'      => OS.ruby_bin,
                        'windows'       => OS.windows?,
                        'posix'         => OS.posix?,
                        'mac'           => OS.mac?,
                        'under windows' => OS::Underlying.windows?,
                        'under bsd'     => OS::Underlying.bsd?,
                    })
        table       = Terminal::Table.new
        table.title = 'mkmatter Debug Info'
        table.rows  = rows.to_a
        table.align_column(0, :left)
        
        puts table
      end
      
      map %w[--info -i] => :__print_info
      desc '--info, -i', 'Print script/gem info'
      method_option :'info-format', :type => :string, desc: 'The format of info', enum: %w(table yaml), default: 'table'
      # @return nil
      def __print_info
        format = options[:'info-format']
        rows   = {
            'author(s)':        Mkmatter::GemInfo.authors.join(', '),
            'e-mail':           Mkmatter::GemInfo.email.join(', '),
            'mkmatter version': Mkmatter::VERSION,
            'Ruby version':     RbConfig::CONFIG['RUBY_PROGRAM_VERSION'],
            'Platform':         RbConfig::CONFIG['build_os'],
        }
        case format
          when 'table'
            table                 = Terminal::Table.new
            table.style.alignment = :center
            table.title           = 'mkmatter Info'
            table.rows            = rows.to_a
            table.align_column(0, :left)
            
            puts table
          when 'yaml'
            puts rows.stringify_keys.to_yaml
          else
            # noop
            # this doesn't get run because of
            # the logic of options and their
            # enum parameter.
        end
      end
      
      if Pathname(Dir.home).join('.local/bin/micro').exist?
        class_option(:editor, type: :string, default: "#{Dir.home}/.local/bin/micro")
        
      elsif Methods.which('micro')
        class_option(:editor, type: :string, default: 'micro')
      else
        class_option(:editor, type: :string, default: 'nano')
      end
      desc 'new SUBCOMMAND [options]', 'Make new content'
      subcommand 'new', Mkmatter::App::Classes::NewContent
      desc 'tags SUBCOMMAND [options]', 'Generate or Create tags'
      subcommand 'tags', Mkmatter::App::Classes::Tags
    end
  end
end

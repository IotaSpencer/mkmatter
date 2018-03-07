require 'thor'
require 'paint'
require 'mkmatter/cli/methods'
require 'mkmatter/cli/tags'
module Mkmatter
  module App
    module Classes
      class Tags < Thor
        include Thor::Actions
        desc 'find [options] TYPE', 'find content of type TYPE'
        # @param [String] type Type of content
        def find(type)
          if Mkmatter::Methods.check_if_jekyll
            table                      = Terminal::Table.new
            table.title                = 'Tags'
            table.style.all_separators = true
            table.headings             = ["#{Paint['Path from Jekyll Root', 'white', :bold]}", "#{Paint['Tags', 'white', :bold]}"]
            
            front_matter = Mkmatter::Methods.find_front_matter(type, 'tags')
            front_matter.each do |path, tags|
              path = path.gsub(/#{Mkmatter::Methods.get_jekyll_root}(\/.*)/, '\1')
              table.add_row([path, "#{tags.join("\n")}"])
            end
            table.align_column(1, :right)
            puts table
          else
            $stderr.puts "#{Paint['Error', :red, :bold]}: Not a Jekyll source directory (no '_config.yml' found in any parent directory)"
          end
        end
        
        desc 'new [options] TAG', 'create a new tag'
        # @param [String] tag Tag Name
        def new_tag(tag)
          if Mkmatter::Methods.check_if_jekyll
          
          else
            $stderr.puts "#{Paint['Error', :red, :bold]}: Not a Jekyll source directory (no '_config.yml' found in any parent directory)"
          end
        end
        
        desc 'gen [options]', 'generate tag files'
        option(:'tag-index', type: :string, default: nil, desc: "configures whether generation of tag files will give them a layout file for a tag index, if you don't want generation to give layouts, omit --tag-index", aliases: %w(-i))
        option(:'dry-run', type: :boolean, default: false, desc: 'Performs a dry run and prints out what it was going to do')
        
        def gen # only used for posts
          if options[:'dry-run']
            if Mkmatter::Tags.has_tag_folder?
              front_matter = Mkmatter::Methods.find_front_matter('post', 'tags')
              tags         = []
              front_matter.each do |key, value|
                tags << value
              end
              all_tags = tags.flatten.sort.uniq
              Mkmatter::Tags.dry_gen all_tags
            else
              $stderr.puts "#{Paint['Error', :red, :bold]}: No tag folder"
            end
          else
            if Mkmatter::Tags.has_tag_folder?
              front_matter = Mkmatter::Methods.find_front_matter('post', 'tags')
              tags         = []
              front_matter.each do |key, value|
                tags << value
              end
              all_tags = tags.flatten.sort.uniq
              Mkmatter::Tags.gen_post_tags all_tags
            else
              $stderr.puts "#{Paint['Error', :red, :bold]}: Not a Jekyll source directory (no '_config.yml' found in any parent directory)"
            end
          end
        end
      end
    end
  end
end
require 'mkmatter/cli/methods'
require 'thor'
require 'front_matter_parser'
require 'active_support/inflector'
module Mkmatter
  class Tags < Thor
    include Thor::Actions
    HILINE = HighLine.new($stdin, $stderr, 80)
    
    def Tags.has_tag_folder?
      if Mkmatter::Methods.check_if_jekyll
        if Mkmatter::Methods.get_jekyll_root.join('tag/').exist?
          true
        else
          false
        end
      else
        false
      end
    end
    
    # @param [Array] tags Array of tags to generate pages for
    # @return [Boolean] whether generation was successful
    def Tags.gen_post_tags(tags)
      if Mkmatter::Methods.check_if_jekyll
        if Tags.has_tag_folder?
          if HILINE.agree('Do you have a layout page where tags list the post they belong to? (y/n) ', true)
            tag_index = HILINE.ask 'Whats the layout name? ' do |q|
              q.default = 'tag_index'
              q.confirm = true
            end
            
            tag_index = 'layout: ' + tag_index
          end
          tags.each do |tag|
            file = "#{Mkmatter::Methods.get_jekyll_root}/tag/#{tag}.md"
            self.new.create_file file do
              <<-PUTS
                ---
                #{tag_index unless tag_index.nil?}
                title: #{tag.titleize}
                tag: #{tag}
                ---
              PUTS
            end
          end
        else
        end
      end
    end
    
    def Tags.get_tags
      yaml_loader  = ->(string) {YAML.load(string)}
      files        = []
      front_matter = {}
      
      Find.find(Pathname(Methods.get_jekyll_root).join('_posts').to_path) do |path|
        files << path if path =~ /.*(\.html|\.md)$/
      end
      files.each do |ele|
        yaml = FrontMatterParser::Parser.parse_file(ele, syntax_parser: :md, loader: yaml_loader).front_matter
        front_matter[ele] = yaml['tags'] if yaml['tags']
        front_matter[ele] = yaml['tag'] if yaml['tag']

      end
      front_matter.select! {|k, v| !v.nil?}
      front_matter
    end
  end
end

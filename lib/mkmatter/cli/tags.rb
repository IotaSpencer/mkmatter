require 'mkmatter/cli/methods'

module Mkmatter
  class Tags
    
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
    
    def Tags.gen_post_tags
      if Mkmatter::Methods.check_if_jekyll
        if Tags.has_tag_folder?
        
        else
        end
      end
    end
    
    # @param [String] type Gets tags from content type TYPE
    def Tags.get_tags_of_type(type)
      unless type =~ /^(post|page)$/
        raise ArgumentError
      end
      yaml_loader       = ->(string) {YAML.load(string)}
      files             = {}
      html_front_matter = []
      md_front_matter   = []
      front_matter      = {}
      case type
        when 'page'
          Find.find(Methods.get_jekyll_root.to_s) do |path|
            Find.prune if path =~ /(_includes|_layouts|_docs|_site)/ # don't include layouts, includes, site, docs
            Find.prune if path =~ /(_posts)/ # don't include our own posts either
            Find.prune if path =~ /(vendor\/bundle)/ # don't include vendor/
            Find.prune if path =~ /(\/tag\/)/ # don't include our own tags
            html_front_matter << path if path =~ /.*\.html$/
            md_front_matter << path if path =~ /.*\.md$/
          end
        
        when 'post'
          Find.find(Pathname(Methods.get_jekyll_root).join('_posts').to_path) do |path|
            html_front_matter << path if path =~ /.*\.html$/
            md_front_matter << path if path =~ /.*\.md$/
          end
        else
          # noop
      end
      files['html'] = html_front_matter
      files['md']   = md_front_matter
      files.each do |ftype, array|
        array.each do |ele|
          front_matter[ele] = FrontMatterParser::Parser.parse_file(ele, syntax_parser: :md, loader: yaml_loader)[key]
        end
      end
      front_matter.select! {|k, v| !v.nil?}
      front_matter
    end
  end
end

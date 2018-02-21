require 'highline'
require 'find'
require 'yaml'
module Mkmatter
  class Methods
    # @return [Boolean] whether current directory is inside a jekyll site source directory
    def Methods.check_if_jekyll
      cwd = Pathname.new('.')
      cwd.ascend do |path|
        if path.join('_config.yml').exist?
          break true
        elsif cwd.to_s == '/'
          # hit root, stop
          break false
        end
      end
    end
    
    # @return [Pathname] path of current jekyll site source roo
    def Methods.get_jekyll_root
      if Methods.check_if_jekyll
        cwd = Pathname.new('.').realdirpath
        cwd.ascend do |path|
          if path.join('_config.yml').exist?
            return path
          else
            next
          end
        end
      end
    end
    
    # @return [NilClass] nil
    def Methods.launch_editor(file_path)
      hl = HighLine.new($stdin, $stderr, 80)
      if file_path
        if hl.agree("Would you like to open an editor? ('editor' command) ", true)
          pid = spawn("editor #{file_path}")
          Process.wait pid
        end
      end
    end
    
    # @param [String] type type of content
    # @param [String] key root yaml directive to return
    # @return [Hash] front matter
    def Methods.find_front_matter(type, key)
      unless type =~ /^(post|page)$/
        $stderr.puts "#{HighLine.color('Error', :red, :bold)}: Invalid Argument, allowed values: post, page"
        exit 1
      end
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
          front_matter[ele] = YAML.load_file(ele)[key]
        end
      end
      front_matter.select! {|k, v| !v.nil?}
      front_matter
    end
  end
end
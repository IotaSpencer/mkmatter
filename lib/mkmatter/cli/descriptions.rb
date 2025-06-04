require "highline"
require "paint"
HighLine.colorize_strings

module Mkmatter
  module App
    module Descriptions
      module New
        NEW = ERB.new(<<-NEW
        --`mkmatter new --type=page` will run you through making a jekyll page.
        --Given the above options/flags you can either output the 'front matter'
        --to STDOUT, or to a file. 
        --outputs your front matter, or whether to mark it as published.
        
        --`mkmatter new post` will run you through making a jekyll post.
        --Given the above options/flags you can modify how the script
        --outputs your front matter, and whether to mark it as published,
        --or as a draft and move it into `_drafts`.
        --<%= Paint['NOTES', 'green', :bold] %>:
        ----By default Jekyll will publish a post if `published` is omitted in
        ----the front matter. So if you omit `--publish` you will publish,
        ----so you have to explicitly use --no-publish to set 
        ----`<%= HighLine.color('published', :yellow) %>: <%= HighLine.color('false', :yellow, :bold) %>`

        --`mkmatter new --type=LAYOUT_TYPE` will run you through making a page using a custom
        --layout type. This is useful for making a page that is not a post or a page. 
        --
        --Examples of this include:
        ----A bulma-clean-theme showcase page (--type=showcase)
        ----A bulma-clean-theme recipe page (--type=recipe)
        ----A bulma-clean-theme products page (--type=products)
        --<%= Paint['OPTIONS', 'green', :bold] %>:

        NEW
        ).result
      end

      module Tags
        GEN = ERB.new(<<-GENDOC

        GENDOC
        ).result
      end
    end
  end
end

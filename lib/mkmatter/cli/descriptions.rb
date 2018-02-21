require 'highline'
HighLine.colorize_strings

module Mkmatter
  module App
    module Descriptions
      module New
        PAGE = <<-PAGEDOC
        `mkmatter new page` will run you through making a jekyll page.

        Given the above options/flags you can modify how the script

        outputs your front matter, or whether to mark it as published.

        PAGEDOC

        POST = <<-POSTDOC
          `mkmatter new post` will run you through making a jekyll post.

          Given the above options/flags you can modify how the script

          outputs your front matter, and whether to mark it as published,

          or as a draft and move it into `_drafts`.

          NOTES:


            By default Jekyll will publish a post if `published` is omitted in

            the front matter. So if you omit `--publish` you will publish,

            so you have to explicitly use --no-publish to set `<%= HighLine.color('published', :yellow) %>:
             <%= HighLine.color('false', :yellow, :bold) %>`

        POSTDOC
      end

      module Tags
        GEN = <<-GENDOC

        GENDOC
      end
    end
  end
end

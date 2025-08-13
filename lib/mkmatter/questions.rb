# frozen_string_literal: true

require 'highline'

module Mkmatter
  class Questions
    attr :answers

    @@hl = HighLine.new

    def ask(type, include_post_qs)
      known_questions = methods.sort.delete_if { |m| m.to_s !~ /^get_.*$/ }
      if type != "post"
        if include_post_qs
        else
          post_only_questions = [
            :get_002_tags,
            :get_003_categories,
            :get_006_summary,
          ]
          2.times do
            for q in known_questions
              if post_only_questions.include?(q)
                known_questions.delete(q)
              end
            end
          end
        end
        # puts known_questions
      end
      known_questions.each do |m|
        @answers[:layout] = type
        @answers[m.to_s.gsub(/^get_[0-9]{3}_/, '')] = method(m).call
      end
      @answers
    end

    # @!visibility private
    def initialize
      @answers = {}
    end

    def get_001_title
      title = @@hl.ask 'Title: '
      if @@hl.agree("Would you like it 'titleized' (Title instead of title)? ", true)
        title.titleize
      else
        title
      end
    end

    # @return [Array]
    def get_002_tags
      @@hl.ask("Tags? (write one on each line, then press '.' then press 'Enter')") do |q|
        q.gather = '.'
      end
    end

    # @return [Array]
    def get_003_categories
      @@hl.ask("Categories? (write one on each line, then press '.' then press 'Enter')") do |q|
        q.gather = '.'
      end
    end

    # @return [String]
    def get_004_file_format
      @@hl.choose do |menu|
        menu.header = "Choose whether you want HTML or Markdown"
        menu.choice "html" do
          return "html"
        end
        menu.choice "md" do
          return "md"
        end
        menu.prompt = "? "
      end
    end

    # @return [String]
    def get_005_extra_fields
      fields = {}
      custom_fields = nil
      cfh = nil
      if @@hl.agree("Do you want to add custom fields? ", true)
        @@hl.say(<<~EXTRA_FIELDS)
          These fields will be usable as {{LAYOUT_TYPE.FIELD}} in pages/posts etc.
          Your fields should be inputted as FIELD=>TEXT HERE
          Type 'EOL' on a new line then press Enter when you are done.
          <%= color('NOTE', :bold, RED) %>: Input is <%= color('NOT', :bold, RED) %> evaluated!
        EXTRA_FIELDS
        custom_fields = @@hl.ask('Fields?') do |q|
          q.gather = '.'
        end
      end
      if !custom_fields.empty?
        custom_fields.each do |field|
          fields.store(field.to_sym, 'nil')
        end
      end
      if custom_fields.empty?
        @@hl.say('No extra fields were added.')
        return
      else
        @@hl.say("#{fields} #{fields.class}")
        cfh = @@hl.ask("Value of field '<%= key %>'?") do |q|
          q.gather = fields
        end
      end
      cfh
    end

    def get_006_summary
      summary = nil
      summary_if = @@hl.agree('Summary? ', true)
      if summary_if
        summary = @@hl.ask(<<~SUMMARYDOC) do |q|
          Input a summary of the post.
          This will be outputted as a summary in the front matter.
          This is useful for a post that is long and you want to
          show a summary of the post.
        SUMMARYDOC
          q.gather = '.'
        end
      end
      summary.join("\n")
    end
  end
end

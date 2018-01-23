# Jekyllposter

Jekyllposter is a gem designed to make it easy to generate front matter for files and also subsequently edit them.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyllposter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyllposter

## Usage

### Using 'mkmatter'

If you want to use 'mkmatter', an executable that ships with `jekyllposter`, all you have to do is run it.

```
$ mkmatter
```

Which will ask you questions about the post you want to put out.

* If you want to make multiple scripts, the script automatically loops itself and resets its variables.

* The script also will open an editor (the 'editor' command) if allowed to, as to allow the user to begin editing their file, frontmatter already included.

## Contributing

* [Bug Reports](/issues)
* [Pull Requests](/pulls)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

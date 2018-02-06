# mkmatter

[![Gem Version](https://badge.fury.io/rb/mkmatter.svg)](https://badge.fury.io/rb/mkmatter)

## Contact

[e-mail](mailto:me@iotaspencer.me) /
[My Website](https://iotaspencer.me) /
[Project Page on IotaSpencer.me](https://iotaspencer.me/projects/mkmatter)

'mkmatter' is a gem designed to make it easy to generate front matter for files and also subsequently edit them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mkmatter'
```

And then execute:

    $ bundle install

### Standalone

To install to the system/user instead of a project, use the following

#### System-wide
As root or by using sudo, run:

```$ gem install mkmatter```

or

```$ sudo gem install mkmatter```

#### User

```$ gem install --user-install mkmatter```

## Usage

### Using 'mkmatter'

If you want to use 'mkmatter', an executable that ships with `mkmatter`, all you have to do is run it.

```
$ mkmatter
```

Which will ask you questions about the post you want to put out.

* If you want to make multiple files, the script automatically loops itself and resets its variables.

* The script also will open an editor (the 'editor' command) if allowed to, as to allow the user to begin editing their file, front-matter already included.

## Contributing

* I am open to the idea of adding more questions/modules if there are plugins that require more configuration in the front matter. Just let me know!

* [Bug Reports](https://github.com/IotaSpencer/mkmatter/issues)
* [Pull Requests](https://github.com/IotaSpencer/mkmatter/pulls)



<!--

**Tutorial**: [mkmatter Tutorial on IotaSpencer.me](https://iotaspencer.me/)



-->

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

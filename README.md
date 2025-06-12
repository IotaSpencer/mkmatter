# mkmatter

<img src="https://uploads.iotaspencer.me/mkmatter_logo_3_face_2.png" width="200px" height="200px">

[![Gem](https://img.shields.io/gem/v/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![GitHub tag](https://img.shields.io/github/tag/IotaSpencer/mkmatter.svg?style=for-the-badge)](https://github.com/IotaSpencer/mkmatter/tree/)

[![Gem](https://img.shields.io/gem/dt/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![Gem](https://img.shields.io/gem/dtv/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[![forthebadge](https://forthebadge.com/images/badges/uses-badges.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/uses-git.svg)](https://forthebadge.com)

## Contact

If you install `mkmatter` Please let me know, I'd love to know the people using this!

[![E-mail](https://img.shields.io/badge/Email-Me-green.svg?style=for-the-badge)](mailto:me@iotaspencer.me)
[![Twitter Follow](https://img.shields.io/twitter/follow/KenISpencer.svg?label=Follow%20Me%20on%20Twitter&style=for-the-badge)](https://twitter.com/KenISpencer)
[![Website](https://img.shields.io/website-up-down-green-red/https/iotaspencer.me.svg?label=My%20Site%20-%20IotaSpencer%2Eme&style=for-the-badge)](https://iotaspencer.me)
[![E-mail](https://img.shields.io/badge/mkmatter%20on%20IotaSpencer%2eme-Project-green.svg?style=for-the-badge)](https://iotaspencer.me/projects/mkmatter)

## About mkmatter

'mkmatter' is a gem designed to make it easy to generate front matter for files and also subsequently edit them.

**Note**: Just like Jekyll there are minimal constraints on what is needed to build, but for `mkmatter` all I ask is that there is a `_config.yml` in your site source root, so the executable knows where it is in the filesystem.

This is needed for any part that `reads from/writes to` the filesystem.

## Installation

**Note**: Thanks to [@zyedidia](https://github.com/zyedidia), His project [micro](https://github.com/zyedidia/micro) has been bundled alongside mkmatter. Just by using one command you can install it for your own use.

However, to use micro the way its installed using the gem, you need to have the directory in your `$PATH`.

### Micro Installation

Add 
```shell
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
```
then do

```
bundle exec micro-install
```

If you do install micro, it will use micro by default unless you override it with `--editor=EDITOR`


### Mkmatter Installation

#### Bundler

Add this line to your application's Gemfile:

```ruby
gem 'mkmatter'
```

And then execute:
```
$ bundle install
```

#### Standalone

To install to the system/user instead of a project, use the following

##### System-wide
As root or by using sudo, run:

```
$ gem install mkmatter
```

or

```
$ sudo gem install mkmatter
```

##### User

```
$ gem install --user-install mkmatter
```


## Usage

**See [Wiki](https://github.com/IotaSpencer/mkmatter/wiki)**

**Tutorial**: [mkmatter Tutorial on IotaSpencer.me](https://iotaspencer.me/2025-XX-XX-mkmatter-tutorial)

## Contributing

### Notes

  * I am open to the idea of adding more questions/modules if there are plugins that require more configuration in the front matter. Just let me know!
    * Most layouts are accounted for via `--type=CUSTOM_TYPE` and then the application asking if there are custom fields you want to add `Mkmatter::Questions.006_get_custom_fields`

### Ways to Contribute

* [Bug Reports](https://github.com/IotaSpencer/mkmatter/issues)
* [Pull Requests](https://github.com/IotaSpencer/mkmatter/pulls)

### Testing

* Due to the nature of how varied the input to the application can be, `mkmatter new --type=TYPE` is not tested in the traditional sense, and is only tested via using `--dry-run` in a non-ci environment, everything else is tested, or known to work via testing of libraries themselves.
  * That is to say, if it asked its questions, and outputted the yaml via `--dry-run` it will more than likely create the directories/files if run without.
  * Therefore; Bugs encountered during Highline prompting inside the `Mkmatter::Questions` class, (most likely `mkmatter new --type=TYPE`), must be reproducable before being looked into.
  * Otherwise Please email [me](mailto:me@iotaspencer.me) if something goes wrong, or create an issue.

  #### Cases
  * If YAML errors out because you put a `:` in a keyname, that's on you.
  * If creating a directory, creates an error, because of a syntax error, that's on you. 
  * Idiot proofing is not a case for tests. Don't be an idiot and create problems for yourself. Know the syntax you are using.
  
* If you know a way I can test some cases, then please contact me.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

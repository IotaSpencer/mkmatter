# mkmatter

###### Builds & Links
[![Travis branch](https://img.shields.io/travis/IotaSpencer/mkmatter/dev.svg?style=for-the-badge)](https://travis-ci.org/IotaSpencer/mkmatter)
[![Travis branch](https://img.shields.io/travis/IotaSpencer/mkmatter/master.svg?style=for-the-badge)](https://travis-ci.org/IotaSpencer/mkmatter)

[![Gem](https://img.shields.io/gem/v/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![GitHub tag](https://img.shields.io/github/tag/IotaSpencer/mkmatter.svg?style=for-the-badge)](https://github.com/IotaSpencer/mkmatter/tree/v3.0.26)


[![Gem](https://img.shields.io/gem/dt/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![Gem](https://img.shields.io/gem/dtv/mkmatter.svg?style=for-the-badge)](https://rubygems.org/gems/mkmatter)
[![Gem](https://img.shields.io/gem/dv/mkmatter/3.0.26.svg?style=for-the-badge)](https://github.com/IotaSpencer/mkmatter/tree/v3.0.26)

###### Badges

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[![forthebadge](https://forthebadge.com/images/badges/uses-badges.svg)](https://forthebadge.com)

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

[![forthebadge](https://forthebadge.com/images/badges/uses-git.svg)](https://forthebadge.com)



## Contact

[![E-mail](https://img.shields.io/badge/Email-Me-green.svg?style=for-the-badge)](mailto:me@iotaspencer.me)
[![Website](https://img.shields.io/website-up-down-green-red/https/iotaspencer.me.svg?label=My%20Site%20-%20IotaSpencer%2Eme&style=for-the-badge)](https://iotaspencer.me)
[![E-mail](https://img.shields.io/badge/mkmatter%20on%20IotaSpencer%2eme-Project-green.svg?style=for-the-badge)](https://iotaspencer.me/projects/mkmatter)
[![Twitter Follow](https://img.shields.io/twitter/follow/IotaEcode.svg?label=Follow%20Me%20on%20Twitter&style=for-the-badge)](https://twitter.com/IotaEcode)

## About mkmatter

'mkmatter' is a gem designed to make it easy to generate front matter for files and also subsequently edit them.

**Note**: Just like Jekyll there are minimal constraints on what is needed to build, but for `mkmatter` all I ask is that there is a `_config.yml` in your site source root, so the executable knows where it is in the filesystem.

This is needed for any part that `reads from/writes to` the filesystem.

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

If you want to use 'mkmatter', an executable that ships with `mkmatter`, you gots to run it

**Note**: Due to minimal constraints in Jekyll, I require at least an empty `_config.yml` file at the root of your source directory. 

**P.S.**: **It does not have to have any directives, it can be an empty file.**

#### Command 'new'

 1. 'new' is for generating front matter and content
 
 1. The current commands under 'new' are 'post' and 'page'
 
Which will ask you questions about the content you want to put out. 
* The script also will open an editor (the 'editor' command) if allowed to, as to allow the user to begin editing their file, front-matter already included.

## Contributing

* I am open to the idea of adding more questions/modules if there are plugins that require more configuration in the front matter. Just let me know!

* [Bug Reports](https://github.com/IotaSpencer/mkmatter/issues)
* [Pull Requests](https://github.com/IotaSpencer/mkmatter/pulls)

<!--
**Tutorial**: [mkmatter Tutorial on IotaSpencer.me](https://iotaspencer.me/2018-02-XX-mkmatter-tutorial)
-->

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

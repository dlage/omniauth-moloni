![Ruby](https://github.com/dlage/omniauth-moloni/workflows/Ruby/badge.svg?branch=master)

# OmniAuth Moloni

This is an unofficial OmniAuth strategy for authenticating to Moloni. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [Moloni Applications Page](https://www.moloni.pt/dev/autenticacao/).

## Installation

```ruby
gem 'omniauth-moloni', github: 'dlage/omniauth-moloni', branch: 'master'
```

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :moloni, ENV['MOLONI_KEY'], ENV['MOLONI_SECRET']
end
```

## Basic Usage Rails

In `config/initializers/moloni.rb`

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :moloni, ENV['MOLONI_KEY'], ENV['MOLONI_SECRET']
end
```

## Moloni Sandbox Usage

```ruby
provider :moloni, ENV['MOLONI_KEY'], ENV['MOLONI_SECRET'],
         {
           :client_options => {
             :site => 'https://api.moloni.pt/sandbox/',
             :authorize_url => 'https://api.moloni.pt/sandbox/authorize/',
             :token_url => 'https://api.moloni.pt/sandbox/grant/'
           }
         }
```

## License

Copyright (c) 2022 Dinis Lage

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

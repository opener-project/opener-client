# Opener::Client

This is a ruby library that makes it very easy to connect to OpeNER webservices

## Installation

Add this line to your application's Gemfile:

    gem 'opener-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opener-client

## Usage

You have to create your own OpeNER pipeline. You can do this like this:

```ruby
require 'opener/client'

class Basic < Opener::Client::Pipeline
  # Define your processors. The order matters.
  define_processors "language-identifier",
                    "tokenizer",
                    "pos-tagger",
                    "polarity-tagger",
                    "ner",
                    "opinion-detector"

  # Defaults to :async, the other option is :sync
  processor_style :async

  webservice_host "http://opener.olery.com"
end
```

That's it basically. You can now process files like this:

```ruby
pipeline = Basic.new
response = pipeline.process("This is the text to analyse")
```

By default the async callback chain is used. So the response will contain
an output url where you can find your output after a few seconds.

Check out the examples folder in this repository for a more extensive example.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

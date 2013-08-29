module OpenerNLP
  module Processor
    attr_reader :host

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def processor(processor)
        define_method "processor" do
          return processor
        end
      end
    end

    def initialize(host)
      @host = host
    end

    def process(input, callbacks=nil)
      opts = {:input=>input}.merge(options)
      opts[:'callbacks[]'] = callbacks unless callbacks.nil?

      response = HTTPClient.post(endpoint, opts)
      if response.status == 500
        raise "Internal Server error in: #{self.class.name}, #{response.body}"
      else
        return response.body
      end
    end

    def endpoint
      [host, processor].join("/")
    end

    def options
      {}
    end
  end
end

require 'json'

module Opener
  module Webservice
    class Pipeline
      include ProcessorDefiner
      include Processors

      def self.processor_style(style)
        @@style = style
      end

      def self.webservice_host(host=nil)
        @@host = host
      end

      def pipe
        @pipe ||= self.class.processors.map{|p| p.new(@@host)}
      end

      def process_sync(input)
        pipe.inject(input) do |memo, pipe|
          memo = pipe.process(memo)
        end
      end

      def process_async(input)
        endpoints = pipe.map(&:endpoint)

        callbacks = endpoints[1..-1]
        callbacks << @@host+"/outlet"

        pipe[0].process(input, callbacks)
      end

      def process(input)
        json_to_hash send(:"process_#{@@style}", input)
      end

      private

      def json_to_hash(response)
        JSON.parse(response)
      end
    end
  end
end

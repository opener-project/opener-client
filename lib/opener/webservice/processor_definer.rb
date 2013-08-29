module OpenerNLP
  module ProcessorDefiner
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      @@processors = []

      def add_processor(processor)
        @@processors << processor
      end

      def processors
        @@processors
      end

      def define_processors(*paths)
        paths.each do |p|
          define_processor(p)
        end
      end

      def define_processor(p)
        klass_name = p.split("-").map(&:camelize).join

        if !const_defined?(klass_name)
          klass = const_set(klass_name,Class.new)
        else
          klass = const_get(klass_name)
        end

        klass.class_eval do
          include Processor
          processor p
        end

        self.add_processor klass
      end

    end
  end
end


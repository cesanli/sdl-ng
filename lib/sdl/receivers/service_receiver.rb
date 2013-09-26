require_relative '../base/service'
module SDL
  module Receivers
    class ServiceReceiver
      include ActiveSupport::Inflector

      attr :service

      def initialize(sym, compendium)
        @service = SDL::Base::Service.new(sym.to_s)

        compendium.fact_classes.each do |fact_class|
          define_singleton_method("has_#{fact_class.local_name.underscore}") do |&block|
            fact_instance = fact_class.new

            fact_instance.receiver.instance_eval &block if block

            @service.facts << fact_instance
          end

          define_singleton_method("#{fact_class.local_name.underscore}") do |&block|
            fact_instance = fact_class.new

            fact_instance.receiver.send "#{fact_class.local_name.underscore}", args[0]
            fact_instance.receiver.instance_eval &block if block

            @service.facts << fact_instance
          end
        end
      end
    end
  end
end
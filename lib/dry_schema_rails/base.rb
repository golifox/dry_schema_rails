require 'dry-schema'
require 'active_support/core_ext/class/attribute'

module DrySchemaRails
  class Base
    class_attribute :_schema_proc, default: -> {}

    class << self
      def call(*args)
        params.call(*args)
      end

      def params
        Dry::Schema.Params(&_schema_proc)
      end

      alias :contract :params

      def schema(&block)
        if block_given?
          self._schema_proc = block
        else
          _schema_proc
        end
      end
    end
  end
end

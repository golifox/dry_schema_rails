require 'dry-schema'

module DrySchemaRails
  class Base
    class << self
      def _schema_proc
        @_schema_proc ||= -> {}
      end

      def _schema_proc=(proc)
        @_schema_proc = proc
      end

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
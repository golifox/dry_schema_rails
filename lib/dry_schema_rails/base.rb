require 'dry-schema'

module DrySchemaRails
  # Base class serves as a foundational class designed to encapsulate
  # common functionalities associated with schema definitions. It provides a
  # blueprint for creating new schema classes efficiently and consistently.
  #
  # The core mechanism of this class hinges on the `class_attribute` called
  # `_schema_proc`, which stores the schema's definition as a proc.
  # This proc gets executed in the context of `Dry::Schema` to define the schema.
  #
  #  Example Usage:
  #
  # To create a new schema, simply inherit from the Base class and provide
  # the schema definition inside a block passed to the `schema` class method.
  #
  # Example:
  #   BaseSchema = Class.new(DrySchemaRails::Base)
  #   UserSchema = Class.new(BaseSchema) do
  #     schema do
  #       required(:username).filled(:string)
  #       required(:email).filled(:string, format?: /@/)
  #       required(:age).filled(:integer, gt?: 18)
  #     end
  #   end
  #
  #   user_params = { username: "John", email: "john@example.com", age: 25 }
  #   result = UserSchema.params.call(user_params)
  #   OR
  #   result = UserSchema.call(user_params)
  #
  #   puts result.success?   # => true
  #   puts result.errors     # => {}
  #
  # This approach allows for the creation of multiple schema classes in a concise
  # and consistent manner, all inheriting common functionality from the base
  # Base class.
  class Base
    class << self
      def _schema_proc
        @_schema_proc ||= -> {}
      end

      def _schema_proc=(proc)
        @_schema_proc = proc
      end

      # @return [Dry::Schema::Result] the schema matching result
      def call(*args)
        params.call(*args)
      end

      # Using to create custom validators easy.
      #
      #  Example:
      #
      #  UserSchema = Class.new(DrySchemaRails) do
      #    schema do
      #      required(:name).filled(:string)
      #      required(:email).filled(:string)
      #    end
      #  end
      #
      #  class UserValidator < Dry::Validation::Contract
      #    params UserSchema.params
      #    # OR
      #    params UserSchema.contract
      #
      #    rule(:name) do
      #      key.failure('name is too short') if value.length < 3
      #    end
      #  end
      #
      #  validation = UserSchema.params
      #
      # @return [Dry::Schema::Params] the schema definition
      def params
        Dry::Schema.Params(&_schema_proc)
      end

      alias :contract :params

      # Using in rails controllers.
      #
      #  Example:
      #
      #  UserSchema = Class.new(BaseSchema) do
      #    schema do
      #      required(:name).filled(:string)
      #      optional(:email).filled(:string)
      #    end
      #  end
      #
      #  class ApplicationController < ActionController::Base
      #    before_action do
      #       if safe_params&.failure?
      #        render json: { errors: safe_params.errors.to_h }, status: :bad_request
      #       end
      #    end
      #  end
      #
      #  class UsersController < ApplicationController
      #    schema(:create, &UserSchema.schema)
      #
      #    def create
      #      @user = User.create(safe_params.output)
      #      render json: @user, status: :created
      #    end
      #  end
      #
      # @return [Proc] the schema definition
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
require "spec_helper"

RSpec.describe DrySchemaRails::Base do
  let(:test_schema_class) do
    Class.new(described_class) do
      schema do
        required(:username).filled(:string)
        required(:email).filled(:string, format?: /@/)
        required(:age).filled(:integer, gt?: 18)
      end
    end
  end

  describe '.call' do
    context 'when provided with valid input' do
      let(:valid_input) { { username: 'John', email: 'john@example.com', age: 25 } }

      it 'returns a success result' do
        result = test_schema_class.call(valid_input)
        expect(result).to be_success
        expect(result.errors).to be_empty
      end
    end

    context 'when provided with invalid input' do
      let(:invalid_input) { { username: '', email: 'invalid_email', age: 15 } }

      it 'returns a failure result with error messages' do
        result = test_schema_class.call(invalid_input)
        expect(result).to be_failure
        expect(result.errors[:username]).to include("must be filled")
        expect(result.errors[:email]).to include("is in invalid format")
        expect(result.errors[:age]).to include("must be greater than 18")
      end
    end
  end
end

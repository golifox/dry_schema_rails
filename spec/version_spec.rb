require 'spec_helper'

RSpec.describe 'VERSION' do
  it 'has a right version number' do
    expect(DrySchemaRails::VERSION).to eq('0.1.1')
  end
end
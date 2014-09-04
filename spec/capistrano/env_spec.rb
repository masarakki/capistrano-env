require 'rails_helper'

describe Capistrano::Env do
  it 'should have a version number' do
    expect(Capistrano::Env::VERSION).not_to be_nil
  end
end

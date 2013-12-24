require 'spec_helper'

describe Capistrano::Env do
  it 'should have a version number' do
    Capistrano::Env::VERSION.should_not be_nil
  end

  it 'should do something useful' do
    false.should be_true
  end
end

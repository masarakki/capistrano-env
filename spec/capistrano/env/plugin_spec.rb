require 'spec_helper'
require 'capistrano'

describe Capistrano::Env::Plugin do
  let(:capistrano) { Capistrano::Configuration.new }

  describe :capenv do
    let(:setup) { capistrano.capenv.use {|config| ; } }
    it 'add task' do
      expect(capistrano.capenv).to receive(:add)
      setup
    end
    it { expect(setup).to be_a Capistrano::Env::Config }
  end
end

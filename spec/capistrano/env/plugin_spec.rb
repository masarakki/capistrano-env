require 'spec_helper'
require 'capistrano'

describe Capistrano::Env::Plugin do
  let(:capistrano) { Capistrano::Configuration.new }

  describe "#capenv" do
    let(:setup) { capistrano.capenv.use {|config| config.add "HELLO", "WORLD" } }

    it "add task" do
      expect(capistrano.capenv).to receive(:add)
      setup
    end
    it { expect(setup).to be_a Capistrano::Env::Config }

    it "set default_environment" do
      setup
      expect(capistrano.fetch(:default_environment)).to eq "HELLO" => "WORLD"
    end
  end
end

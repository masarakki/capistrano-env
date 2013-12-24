require 'spec_helper'

describe Capistrano::Env::Strategy do
  let(:capistrano) { Capistrano::Configration.new }
  before do
    capistrano.extend(Capistrano::Spec::ConfigurationExtension)
    described_class.load_into(capistrano)
  end

end

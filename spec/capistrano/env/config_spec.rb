require 'spec_helper'

describe Capistrano::Env::Config do
  let(:config) { described_class.new }
  it { expect(config.formatter).to eq :ruby }

  describe :add do
    before do
      ENV["CAPENV_TEST_A"] = "a"
      ENV["CAPENV_TEST_B"] = "1,2,3"
      ENV["CAPENV_TEST"] = "$"
      ENV["VAPENV_XYZ_A"] = "X"
    end

    describe :regex do
      before do
        config.add /^CAPENV_TEST_/
      end
      it { expect(config.envs).to eq({"CAPENV_TEST_A" => "a", "CAPENV_TEST_B" => "1,2,3"}) }
    end
    describe :string do
      before do
        config.add "CAPENV_TEST"
      end
      it { expect(config.envs).to eq({"CAPENV_TEST" => "$"}) }
    end
    describe :override do
      before do
        config.add /^CAPENV_TEST_/
        config.add "CAPENV_TEST_B", "UNKO"
      end
      it { expect(config.envs).to eq({"CAPENV_TEST_A" => "a", "CAPENV_TEST_B" => "UNKO"}) }
    end
  end
end

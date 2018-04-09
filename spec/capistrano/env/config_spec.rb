require 'gem_helper'
require 'capistrano/env/config'

RSpec.describe Capistrano::Env::Config do
  describe 'new with block' do
    before do
      ENV['CAPENV_TEST_A'] = 'a'
    end
    let(:proc) { ->(env) { env.add(/CAPENV_TEST/) } }
    subject { described_class.new(&proc).envs }
    it { is_expected.to eq('CAPENV_TEST_A' => 'a') }
  end

  let(:config) { described_class.new }
  subject { config }

  its(:filename) { is_expected.to eq '.env' }

  describe '#add' do
    before do
      ENV['CAPENV_TEST_A'] = 'a'
      ENV['CAPENV_TEST_B'] = '1,2,3'
      ENV['CAPENV_TEST'] = '$'
      ENV['VAPENV_XYZ_A'] = 'X'
    end
    subject { config.envs }

    context 'with regex' do
      before do
        config.add(/^CAPENV_TEST_/)
      end
      it { is_expected.to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => '1,2,3') }
    end

    context 'with string' do
      before do
        config.add 'CAPENV_TEST'
      end
      it { is_expected.to eq('CAPENV_TEST' => '$') }
    end

    describe 'overridable' do
      before do
        config.add(/^CAPENV_TEST_/)
        config.add 'CAPENV_TEST_B', 'UNKO'
      end
      it { is_expected.to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => 'UNKO') }
    end

    describe 'fix key with block' do
      before do
        config.add(/^CAPENV_TEST_/)
        config.add(/^CAPENV_TEST_/) do |key|
          key.gsub(/CAPENV_/, '')
        end
      end

      it { is_expected.to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => '1,2,3', 'TEST_A' => 'a', 'TEST_B' => '1,2,3') }
    end
  end
end

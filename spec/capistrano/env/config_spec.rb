require 'gem_helper'
require 'capistrano/env/config'

describe Capistrano::Env::Config do
  let(:config) { described_class.new }
  describe '#formatter' do
    it { expect(config.formatter).to eq :dotenv }
  end

  describe '#formatter class' do
    it { expect(config.formatter_class).to eq Capistrano::Env::Formatter::DotenvFormatter }
  end

  describe '#capenv_file' do
    it { expect(config.capenv_file).to eq '.env' }
  end

  describe '#capenv_content' do
    it do
      require 'capistrano/env/formatter/dotenv_formatter'
      allow(config).to receive(:envs).and_return('a' => 'b')
      expect(Capistrano::Env::Formatter::DotenvFormatter).to receive(:format).with('a' => 'b').and_return 'hello'
      expect(config.capenv_content).to eq 'hello'
    end
  end

  describe '#add' do
    before do
      ENV['CAPENV_TEST_A'] = 'a'
      ENV['CAPENV_TEST_B'] = '1,2,3'
      ENV['CAPENV_TEST'] = '$'
      ENV['VAPENV_XYZ_A'] = 'X'
    end

    context 'with regex' do
      before do
        config.add(/^CAPENV_TEST_/)
      end
      it { expect(config.envs).to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => '1,2,3') }
    end
    context 'with string' do
      before do
        config.add 'CAPENV_TEST'
      end
      it { expect(config.envs).to eq('CAPENV_TEST' => '$') }
    end
    describe 'overridable' do
      before do
        config.add(/^CAPENV_TEST_/)
        config.add 'CAPENV_TEST_B', 'UNKO'
      end
      it { expect(config.envs).to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => 'UNKO') }
    end
    describe 'fix key with block' do
      before do
        config.add(/^CAPENV_TEST_/)
        config.add(/^CAPENV_TEST_/) do |key|
          key.gsub(/CAPENV_/, '')
        end
      end
      it { expect(config.envs).to eq('CAPENV_TEST_A' => 'a', 'CAPENV_TEST_B' => '1,2,3', 'TEST_A' => 'a', 'TEST_B' => '1,2,3') }
    end
  end
end

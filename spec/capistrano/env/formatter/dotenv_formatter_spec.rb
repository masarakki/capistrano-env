require 'gem_helper'
require 'capistrano/env/formatter/dotenv_formatter'

describe Capistrano::Env::Formatter::DotenvFormatter do
  let(:envs) { { 'HELLO' => 'WORLD', 'HOGE' => '1,2,3' } }
  let(:expect_string) { "HELLO=\"WORLD\"\nHOGE=\"1,2,3\"\n" }

  it { expect(described_class.format(envs)).to eq expect_string }
  it { expect(described_class.filename).to eq '.env' }
end

require 'spec_helper'
require 'capistrano/env/formatter/dotenv_formatter'

describe Capistrano::Env::Formatter::DotenvFormatter do
  let(:envs) { { 'HELLO' => 'WORLD', 'HOGE' => '1,2,3' } }
  expect_string = <<EOF
HELLO="WORLD"
HOGE="1,2,3"
EOF
  it { expect(described_class.format(envs)).to eq expect_string }
  it { expect(described_class.filename).to eq '.env' }
end

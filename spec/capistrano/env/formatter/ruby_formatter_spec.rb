require 'spec_helper'
require 'capistrano/env/formatter/ruby_formatter'

describe Capistrano::Env::Formatter::RubyFormatter do
  let(:envs) { { 'HELLO' => 'WORLD', 'HOGE' => '1,2,3' } }
  expect_string = <<EOF
ENV["HELLO"] = "WORLD"
ENV["HOGE"] = "1,2,3"
EOF
  it { expect(described_class.format(envs)).to eq expect_string }
end

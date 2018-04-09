require 'gem_helper'
require 'capistrano/env/builder'

RSpec.describe Capistrano::Env::Builder do
  let(:target) do
    Class.new do
      include Capistrano::Env::Builder

      def envs
        { 'HELLO' => 'WORLD', 'HOGE' => '1,2,3' }
      end
    end
  end

  let(:expect_string) { "HELLO=\"WORLD\"\nHOGE=\"1,2,3\"\n" }

  subject { target.new }
  its(:content) { is_expected.to eq expect_string }
end

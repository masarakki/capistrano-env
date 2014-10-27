require 'gem_helper'
require 'capistrano/env'

describe Capistrano::Env do
  before do
    Capistrano::Env.use do |env|
      env.add 'HELLO', 'WORLD'
    end
  end

  it { expect(Capistrano::Env.to_s.chomp).to eq 'HELLO="WORLD"' }
  it { expect(Capistrano::Env.envs).to eq 'HELLO' => 'WORLD' }
  it { expect(Capistrano::Env.filename).to eq '.env' }
end

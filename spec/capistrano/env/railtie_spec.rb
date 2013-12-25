require 'spec_helper'

describe "Capistrano::Env::Railtie" do
  describe "use in application.rb" do
    it { expect(Rails.configuration.hello).to eq "WORLD" }
  end

  describe "use in initializers" do
    it { expect(Rails.configuration.hoge).to eq "HAGE" }
  end
end

require 'capistrano/env/config'
require 'capistrano/env/version'

module Capistrano
  module Env
    def self.use(&block)
      block.call(config)
    end

    def self.envs
      config.envs
    end

    def self.to_s
      config.content
    end

    def self.filename
      config.filename
    end

    def self.filemode
      config.filemode
    end

    def self.config
      @config ||= Capistrano::Env::Config.new
    end
  end
end

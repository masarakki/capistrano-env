require 'capistrano/env/config'

module Capistrano
  module Env
    def self.use(&block)
      block.call(config)
    end

    def self.envs
      config.envs
    end

    def self.to_s
      config.capenv_content
    end

    def self.filename
      config.capenv_file
    end

    def self.filemode
      config.capenv_filemode
    end

    def self.config
      @config ||= Capistrano::Env::Config.new
    end
  end
end

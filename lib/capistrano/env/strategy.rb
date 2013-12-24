require 'capistrano'

module Capistrano
  module Env
    class Strategy
      def self.load_into(capistrano_config)
        capistrano_config.load do
          namespace :env do
            task :gen do

            end
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  Capistrano::Env::Strategy.load_into(Capistrano::Configuration.instance)
end

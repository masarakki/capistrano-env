module Capistrano
  module Env
    module Plugin
      def use
        config = Capistrano::Env::Config.new
        yield(config)
        add config
        config
      end

      def add(config)
        namespace :deploy do
          namespace :copy_env do
          end
        end
#        after 'deploy', "deploy:notify:#{task_name}"
      end
    end
  end
end

Capistrano.plugin :capenv, Capistrano::Env::Plugin

module Capistrano
  module Env
    module Plugin
      def use
        config = Capistrano::Env::Config.new
        yield(config)
        add config
        set :default_environment, config.envs
        config
      end

      def add(config)
        namespace :deploy do
          namespace :capenv do
            namespace :copy do
              [:release, :current].each do |type|
                task type do
                  path = fetch "#{type}_path".to_sym
                  parent.parent.parent.upload StringIO.new(config.capenv_content), "#{path}/#{config.capenv_file}"
                end
              end
            end
          end
        end
        after 'deploy:finalize_update', 'deploy:capenv:copy:release'
        before 'deploy:restart', 'deploy:capenv:copy:current'
      end
    end
  end
end

Capistrano.plugin :capenv, Capistrano::Env::Plugin if Capistrano.respond_to?(:plugin)

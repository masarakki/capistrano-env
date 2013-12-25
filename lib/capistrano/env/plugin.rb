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
          namespace :capenv do
            task :copy do
              parent.parent.upload StringIO.new(config.capenv_content), "#{fetch(:current_path)}/#{config.capenv_file}"
            end
          end
        end
        after 'deploy:finalize_update', 'deploy:capenv:copy'
        before 'deploy:restart', 'deploy:capenv:copy'
      end
    end
  end
end

Capistrano.plugin :capenv, Capistrano::Env::Plugin

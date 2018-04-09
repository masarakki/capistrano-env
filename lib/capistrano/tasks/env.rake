namespace :capenv do
  desc 'copy .env to release_path'
  task :copy do
    on roles(:all) do
      capenv = fetch(:capenv)
      upload! StringIO.new(capenv.content),
              File.join(fetch(:release_path), capenv.filename),
              mode: capenv.filemode
    end
  end

  task :set_envs do
    capenv = Capistrano::Env::Config.new(&fetch(:capenv))
    set :capenv, capenv
    set :default_environment, capenv.envs
  end
end

namespace :load do
  task :defautls do
    set :capenv, -> { ->(env) {} }
  end
end

stages.each do |stage|
  after stage, 'capenv:set_envs'
end

before 'deploy:updated', 'capenv:copy'
before 'deploy:restart', 'capenv:copy'

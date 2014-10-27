namespace :capenv do
  desc 'copy .env to release_path'
  task :copy do
    on roles(:all) do
      upload! StringIO.new(Capistrano::Env.to_s), "#{release_path}/#{Capistrano::Env.filename}"
    end
  end

  task :set_envs do
    set :default_environment, Capistrano::Env.envs
  end
end

stages.each do |stage|
  after stage, 'capenv:set_envs'
end

after 'deploy:updating', 'capenv:copy'
before 'deploy:restart', 'capenv:copy'

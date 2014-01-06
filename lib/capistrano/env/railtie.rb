module Capistrano
  module Env
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        capenv_file = File.expand_path("./capenv.rb", Rails.root)
        require capenv_file if File.exists?(capenv_file)
      end
    end
  end
end

module Capistrano
  module Env
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        p :before_configuration
        capenv_file = File.expand_path("./capenv.rb", Rails.root)
        require capenv_file if File.exists?(capenv_file)
#        p ENV
      end
    end
  end
end

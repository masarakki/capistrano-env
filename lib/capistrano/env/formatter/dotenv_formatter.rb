module Capistrano
  module Env
    module Formatter
      class DotenvFormatter
        def self.filename
          '.env'
        end

        def self.format(envs)
          envs.map { |k, v| "#{k}=\"#{v}\"\n" }.join
        end
      end
    end
  end
end

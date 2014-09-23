module Capistrano
  module Env
    module Formatter
      class RubyFormatter < Base
        def self.extname
          'rb'
        end

        def self.format(envs)
          envs.map { |k, v| "ENV[\"#{k}\"] = \"#{v}\"\n" }.join
        end
      end
    end
  end
end

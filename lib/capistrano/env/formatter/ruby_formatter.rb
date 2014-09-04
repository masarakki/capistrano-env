module Capistrano
  module Env
    module Formatter
      class RubyFormatter
        def self.file_ext
          'rb'
        end

        def self.format(envs)
          envs.map { |k, v| "ENV[\"#{k}\"] = \"#{v}\"\n" }.join
        end
      end
    end
  end
end

module Capistrano
  module Env
    module Formatter
      class Base
        def self.filename
          "capenv.#{extname}"
        end
      end
    end
  end
end

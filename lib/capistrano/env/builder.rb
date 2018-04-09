module Capistrano
  module Env
    module Builder
      def content
        envs.map { |k, v| "#{k}=\"#{v}\"\n" }.join
      end
    end
  end
end

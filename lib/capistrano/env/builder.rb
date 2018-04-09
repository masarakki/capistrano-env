module Capistrano
  module Env
    module Builder
      def filename
        '.env'
      end

      def content
        envs.map { |k, v| "#{k}=\"#{v}\"\n" }.join
      end
    end
  end
end

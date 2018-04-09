require 'capistrano/env/builder'

module Capistrano
  module Env
    class Config
      include Capistrano::Env::Builder
      attr_accessor :filemode, :filename
      attr_reader :envs

      def initialize
        @envs = {}
        @filemode = '0640'
        @filename = '.env'
        yield(self) if block_given?
      end

      def inspect
        envs
      end

      def add(name_or_regexp, val = nil, &block)
        if val && name_or_regexp.is_a?(String)
          set_env(name_or_regexp, val)
        else
          find_envs(name_or_regexp).each do |key, value|
            set_env(key, value, &block)
          end
        end
      end

      private

      def set_env(key, value)
        key = yield(key) if block_given?
        @envs[key] = value
      end

      def find_envs(key)
        case key
        when Regexp
          ENV.select { |x| x =~ key }
        else
          ENV.select { |x| x == key }
        end
      end
    end
  end
end

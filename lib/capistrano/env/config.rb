require 'capistrano/env/builder'

module Capistrano
  module Env
    class Config
      include Capistrano::Env::Builder
      attr_accessor :filemode

      def initialize
        @values = {}
        @keys = []
        @filemode = '0640'
      end

      def add(name_or_regexp, val = nil, &block)
        if val && name_or_regexp.is_a?(String)
          @values[name_or_regexp] = val
        else
          @keys << [name_or_regexp, block]
        end
      end

      def envs
        result = {}
        @keys.each do |key, block|
          key_values = key.is_a?(Regexp) ? ENV.select { |x| x =~ key } : ENV.select { |x| x == key }
          key_values = Hash[key_values.map { |k, v| [block.call(k), v] }] if block
          result.merge!(key_values)
        end
        result.merge(@values)
      end
    end
  end
end

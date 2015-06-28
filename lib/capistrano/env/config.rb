require 'capistrano/env/formatter'

module Capistrano
  module Env
    class Config
      attr_accessor :formatter
      attr_accessor :filemode

      def initialize
        @values = {}
        @keys = []
      end

      def formatter
        self.formatter = :dotenv unless @formatter
        @formatter
      end

      def filemode
        self.filemode = '0640' unless @filemode
        @filemode
      end

      attr_writer :formatter
      attr_writer :filemode

      def add(name_or_regexp, val = nil, &block)
        if val && name_or_regexp.is_a?(String)
          @values[name_or_regexp] = val
        else
          @keys << [name_or_regexp, block]
        end
      end

      def formatter_class
        @formatter_class ||= begin
                               require "capistrano/env/formatter/#{formatter}_formatter"
                               Capistrano::Env::Formatter.const_get "#{formatter.capitalize}Formatter"
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

      def capenv_file
        formatter_class.filename
      end

      def capenv_content
        formatter_class.format(envs)
      end

      def capenv_filemode
        filemode
      end
    end
  end
end

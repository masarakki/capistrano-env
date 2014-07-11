module Capistrano
  module Env
    class Config
      attr_accessor :formatter

      def initialize
        @formatter = :ruby
        @values = {}
        @keys = []
      end

      def add(name_or_regexp, val = nil, &block)
        if val && name_or_regexp.is_a?(String)
          @values[name_or_regexp] = val
        else
          @keys << [name_or_regexp, block]
        end
      end

      def formatter_class
        @formatter_class ||= begin
                               require "capistrano/env/formatter/#{@formatter}_formatter"
                               Capistrano::Env::Formatter.const_get "#{formatter.capitalize}Formatter"
                             end
      end

      def envs
        result = {}
        @keys.each do |key, block|
          key_values = if key.is_a? Regexp
                         ENV.select{|x| x =~ key }
                       else
                         ENV.select{|x| x == key }
                       end
          if block
            key_values = Hash[key_values.map do |k, v|
              [block.call(k), v]
            end]
          end
          result.merge!(key_values)
        end
        result.merge(@values)
      end

      def capenv_file
        "capenv.#{formatter_class.file_ext}"
      end

      def capenv_content
        formatter_class.format(envs)
      end
    end
  end
end

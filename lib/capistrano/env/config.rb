module Capistrano
  module Env
    class Config
      attr_reader :formatter

      def initialize
        @formatter = :ruby
        @values = {}
        @keys = []
      end

      def add(name_or_regexp, val = nil)
        if val && name_or_regexp.is_a?(String)
          @values[name_or_regexp] = val
        else
          @keys << name_or_regexp
        end
      end

      def formatter=(formatter)
        @fomatter = formatter
      end

      def envs
        result = {}
        @keys.each do |key|
          key_values = if key.is_a? Regexp
                         ENV.select{|x| x =~ key }
                       else
                         ENV.select{|x| x == key }
                       end

          result.merge!(key_values)
        end
        result.merge(@values)
      end
    end
  end
end

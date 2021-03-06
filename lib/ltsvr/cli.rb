# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/16

require 'rubygems'
require 'ltsv'
require 'optparse'
require 'launchy'

module Ltsvr
  class CLI
    def self.execute(stdout, arguments=[])
      options = {}
      options[:keywords]        = []
      options[:ignore_keywords] = []
      options[:filters]         = []
      
      opts = OptionParser.new("#{File.basename($0)} [OPTION] [FILE]...")
      opts.on("-k LABEL", "--keywords"       , "Display keywords   (-k host,ua)")                      {|v| options[:keywords]        << v }
      opts.on("-i LABEL", "--ignore-keywords", "Ignore keywords    (-i time,req)")                     {|v| options[:ignore_keywords] << v }
      opts.on("-f FILTER", "--filter"        , "Filtering keywords (-f host=192.168.1.1,ua=Mozilla)")  {|v| options[:filters]         << v }
      opts.on("--web"                        , "Go to website (http://ltsv.org)")                      {|v| options[:web] = true }
      opts.parse!(arguments)

      if options[:web]
        Launchy.open('http://ltsv.org')
        return
      end

      obj = Ltsvr.new(options)

      if File.pipe?($stdin)
        while line = $stdin.gets
          result = obj.parse_line(line)
          stdout.puts result if result
        end
      elsif arguments.empty?
        stdout.puts opts.help
      else
        arguments.each do |filename|
          io = open(filename)
          while line = io.gets
            result = obj.parse_line(line)
            stdout.puts result if result
          end
        end
      end
    end
  end

  class Ltsvr
    def initialize(options)
      @options = options
      compile
    end
    
    def parse_line(line)
      hash = LTSV.parse(line)[0] || {}

      # filter
      return nil unless @filters.all? {|filter| filter.match? hash}

      # keywords
      result = {}

      if @keywords.empty?
        result = hash
      else
        @keywords.each do |k|
          result[k] = hash[k]
        end
      end

      # ignore_keywords
      @ignore_keywords.each do |k|
        result.delete(k)
      end

      # result
      result_str(result)
    end

    private

    def compile
      @filters         = compile_filter
      @keywords        = compile_keywords
      @ignore_keywords = compile_ignore_keywords
      # p [@filters, @keywords, @ignore_keywords]
    end

    def compile_filter
      @options[:filters].reduce([]) do |result, v|
        result + v.split(",").map do |data|
          d = data.split("=")
          Filter.new(d[0], d[1])
        end
      end
    end

    def compile_keywords
      @options[:keywords].reduce([]) do |result, v|
        result + v.split(",").map{|a|a.intern}
      end
    end

    def compile_ignore_keywords
      @options[:ignore_keywords].reduce([]) do |result, v|
        result + v.split(",").map{|a|a.intern}
      end
    end

    def result_str(hash)
      result = []

      hash.each do |key, value|
        result << "#{key}:#{value}"
      end
      
      result.join(", ")
    end

  end

  class Filter
    def initialize(label, value)
      @label = label.intern
      @value = value
    end

    def match?(hash)
      hash[@label] && hash[@label].match(@value)
    end
  end
  
end

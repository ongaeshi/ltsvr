# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/16

require 'rubygems'
require 'ltsv'
require 'optparse'

module Ltsvr
  class CLI
    def self.execute(stdout, arguments=[])
      options = {}
      options[:keywords]        = []
      options[:ignore_keywords] = []
      options[:filters]         = []
      
      opts = OptionParser.new("#{File.basename($0)}")
      opts.on("-k LABEL", "--keywords"       , "Display keywords   (-k host,ua)")                      {|v| options[:keywords]        << v }
      opts.on("-i LABEL", "--ignore-keywords", "Ignore keywords    (-i time,req)")                     {|v| options[:ignore_keywords] << v }
      opts.on("-f FILTER", "--filter"        , "Filtering keywords (-f host=192.168.1.1,ua=~Mozilla)") {|v| options[:filters]         << v }
      opts.on("--web"                        , "Go to website (http://ltsv.org)")                      {|v| options[:web] = true }
      opts.parse!(arguments)

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
      hash = LTSV.parse(line)[0]
      hash.inspect if @filters.all? {|filter| filter.match? hash}

      # # hash.inspect if @fileters.all {|filter| fileter.match? hash}

      # hash.inspect
    end

    private

    def compile
      filter_compile
    end

    def filter_compile
      # p @options
      @filters = @options[:filters].reduce([]) do |result, v|
        # p v
        d = v.split("=")
        result << Filter.new(d[0], d[1])
        
      end
      # p @filters
    end

  end

  class Filter
    def initialize(label, value)
      @label = label.intern
      @value = value
    end

    def match?(hash)
      hash[@label].match @value
    end
  end
  
end

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
      opts.on("-k", "--keywords"       , "Display keywords   (-k host,ua)")                      {|v| options[:keywords]        << v }
      opts.on("-i", "--ignore-keywords", "Ignore keywords    (-i time,req)")                     {|v| options[:ignore_keywords] << v }
      opts.on("-f", "--filter"         , "Filtering keywords (-f host=192.168.1.1,ua=~Mozilla)") {|v| options[:filters]         << v }
      opts.on("--web"                  , "Go to website(http://ltsv.org)")                       {|v| options[:web] = true }
      opts.parse!(arguments)

      arguments.each do |filename|
        io = open(filename)
        while line = io.gets
          p LTSV.parse(line)[0]
        end
      end
    end
  end
end



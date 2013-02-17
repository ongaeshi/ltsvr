# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/17

require 'ltsvr/cli'
require 'test_helper'

module Ltsvr
  class TestFilter < Test::Unit::TestCase
    def test_match?
      hash = {:host=>"127.0.0.1", :ident=>"-", :user=>"frank", :time=>"[10/Oct/2000:13:55:36 -0700]", :req=>"GET /apache_pb.gif HTTP/1.0", :status=>"200", :size=>"2326", :referer=>"http://www.example.com/start.html", :ua=>"Mozilla/4.08 [en] (Win98; I ;Nav)"}

      assert Filter.new("host", "127.0.0.1").match?(hash)
      assert Filter.new(:host, "127.0.0.1").match?(hash) # Support symbol
      assert !Filter.new("host", "127.0.0.2").match?(hash)
      assert Filter.new("user", "frank").match?(hash)
      assert Filter.new("time", "2000").match?(hash) # Sub match
      assert !Filter.new("time", "2001").match?(hash)
      assert Filter.new("ua", "Mozilla").match?(hash)
    end
  end
end





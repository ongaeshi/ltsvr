# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/17

require 'ltsvr/cli'
require 'test_helper'

module Ltsvr
  class TestCLI < Test::Unit::TestCase
    def setup
      @string_io = StringIO.new
    end

    def teardown
    end

    def test_no_arg
      assert_match /--filter/, command("")
    end

    def test_file_specify
      r = command(fullpath("data/test.ltsv")).split("\n")
      assert_equal 3, r.size 
    end

    private

    def command(arg)
      CLI.execute(@string_io, arg.split)
      @string_io.string
    end

    def fullpath(path)
      File.join(File.dirname(__FILE__), path)
    end
  end
end



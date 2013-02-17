# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2013/02/02

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

    private

    def command(arg)
      CLI.execute(@string_io, arg.split)
      @string_io.string
    end
  end
end



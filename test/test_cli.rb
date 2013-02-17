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
      r = command(TEST_LTSV).split("\n")
      assert_equal 4, r.size 
    end

    def test_filter
      r = command("#{TEST_LTSV} -f user=takashi").split("\n")
      assert_equal 1, r.size
      assert_match /takashi/, r[0]
    end

    def test_filter_multi
      r = command("#{TEST_LTSV} -f user=frank,referer=index").split("\n")
      assert_equal 1, r.size
      assert_match /index.html/, r[0]
    end

    def test_filter_multi_arguments
      r = command("#{TEST_LTSV} -f user=frank,referer=index -f ua=Mozilla").split("\n")
      assert_equal 1, r.size
      assert_match /index.html/, r[0]
    end

    def test_keywords
      r = command("#{TEST_LTSV} -k host,user").split("\n")
      assert_equal "{:host=>\"127.0.0.1\", :user=>\"frank\"}", r[0]
    end

    def test_keywords_multi
      r = command("#{TEST_LTSV} -k host -k user").split("\n")
      assert_equal "{:host=>\"127.0.0.1\", :user=>\"frank\"}", r[0]
    end

    def test_ignore_keywords
      r = command("#{TEST_LTSV} -i ua,referer,time -i ident,req,size,status").split("\n")
      assert_equal "{:host=>\"127.0.0.1\", :user=>\"frank\"}", r[0]
    end

    private

    def command(arg)
      CLI.execute(@string_io, arg.split)
      @string_io.string
    end

    TEST_LTSV = File.join(File.dirname(__FILE__), "data/test.ltsv")
  end
end



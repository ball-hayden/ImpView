#!/usr/bin/env ruby

require 'crxmake'

CrxMake.make(
  :ex_dir => "build",
  :pkey   => ARGV[0],
  :crx_output => "ImpView.crx",
  :ignoredir => /\.(?:svn|git|cvs)/
)
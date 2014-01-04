# coding: utf-8
require File.expand_path("../lib/xctool/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "xctool_wrapper"
  s.platform = "universal-darwin"
  s.version = XCTool::VERSION
  s.summary = "A ruby wrapper around facebook/XCTool that allows you to script xctool using the builder pattern in ruby."
  s.author = "Mickey Reiss"
  s.email = "mickey@venmo.com"
  s.post_install_message = "The xctool_wrapper gem assumes that xctool #{XCTOOL::XCTOOL_VERSION} is installed. Please ensure it is available via `brew install xctool --version #{XCTOOL::XCTOOL_VERSION}`." unless %x{xctool=$(which xctool) && $xctool --version}.strip == "0.1.14"
  s.files = Dir["**/*.rb", "*.md"]
  s.require_path = "lib"
  s.homepage = "https://github.braintreeps.com/mickeyreiss/xctool_wrapper"
  s.license = "MIT"
end

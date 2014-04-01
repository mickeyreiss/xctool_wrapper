module XCTool
  module Configuration
    XCTOOL = ENV["XCTOOL"] || "xctool"

    DEFAULT_REPORTER = 'pretty'

    SDKS = %w{iphonesimulator7.1
              iphonesimulator7.0
              iphonesimulator6.1
              iphonesimulator6.0
              iphonesimulator5.1
              iphonesimulator5.0}
  end
end

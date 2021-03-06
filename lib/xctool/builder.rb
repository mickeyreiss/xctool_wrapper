module XCTool
  class Builder
    include Configuration

    def initialize(workspace, scheme)
      @xctool = XCTool.new
      @workspace = workspace
      @scheme = scheme

      with_defaults
    end

    def with_defaults
      @test_sdks = []
      @xctool.reporter = DEFAULT_REPORTER
      @xctool.scheme = @scheme
      @xctool.sdk = SDKS.first
      @xctool.workspace = @workspace
    end

    def with_reporter reporter
      @xctool.reporter = reporter.to_s
      self
    end

    def with_target(target)
      @xctool.only = target
      self
    end

    def with_sdk(sdk)
      @xctool.sdk = sdk
      self
    end

    def with_all_test_sdks
      @test_sdks = SDKS
      self
    end

    def with_test_sdk(test_sdk)
      @test_sdks << test_sdk
      self
    end

    def with_arch(arch)
      @xctool.arch = arch
      self
    end

    def with_build_setting(setting_name, setting_value)
      @xctool.build_settings << [setting_name, setting_value]
      self
    end

    def build_in(build_dir)
      @xctool.build_settings << ["BUILD_DIR", build_dir]
      self
    end

    def build
      @xctool.append_build
      self
    end

    def archive
      @xctool.append_archive
      self
    end

    def test
      (@test_sdks.empty? ? [@xctool.sdk] : @test_sdks).each do |test_sdk|
        @xctool.append_test(test_sdk)
      end
      self
    end

    def clean
      @xctool.append_clean
      self
    end

    def build_tests
      @xctool.append_build_tests
      self
    end

    def run_tests
      (@test_sdks.empty? ? [@xctool.sdk] : @test_sdks).each do |test_sdk|
        @xctool.append_run_tests(test_sdk)
      end
      self
    end

    def analyze
      @xctool.append_analyze
      self
   end

    def as_cmd
      @xctool.as_cmd
    end

    def to_s
      @xctool.to_s
    end
  end
end

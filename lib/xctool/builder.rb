module XCTool
  class Builder
    extend Configuration

    def initialize
      @cmd = []
      @test_sdks = []
    end

    def self.build(workspace, scheme)
      self.new.instance_eval do |xctool|
        @reporter = DEFAULT_REPORTER
        @scheme = scheme
        @sdk = SDKS.first
        @test_sdks = [SDKS.first]
        @workspace = 'VenmoSDK.xcworkspace'
        self
      end
    end

    def with_reporter reporter
      @reporter = reporter.to_s
      self
    end

    def with_target(target)
      @only = target
      self
    end

    def with_scheme(scheme)
      @scheme = scheme
      self
    end

    def with_sdk(sdk)
      @sdk = sdk
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

    def build
      @cmd << "build"
      return self
    end

    def clean
      @cmd << "clean"
      self
    end

    def build_tests
      @cmd << "build-tests"
      self
    end

    def run_tests
      (@test_sdks | [@sdk]).each do |test_sdk|
        @cmd << <<-CMD
          run-tests
          -test-sdk '#{test_sdk}'
          -failOnEmptyTestBundles
          -freshSimulator
          -parallelize
        CMD
        @cmd << "-only '#{@only}'" if @only
      end
      self
    end

    def analyze
      @cmd << <<-CMD
        analyze
        -failOnWarnings
      CMD
      self
   end

    def to_cmd
      "#{XCTOOL} #{_xctool_params} #{@cmd.join(' ')}".gsub(/\s+/, ' ').strip
    end

    def to_s
      "`#{to_cmd}`"
    end

    def _xctool_params
      cmd = ""
      cmd << "-reporter '#{@reporter}' \ \n" if @reporter
      cmd << <<-CMD
        -workspace '#{@workspace}' \
        -scheme '#{@scheme}' \
        -sdk '#{@sdk}' \
        -configuration Release
      CMD
      cmd
    end
  end
end

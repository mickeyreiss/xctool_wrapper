module XCTool
  class XCTool
    include Configuration
    attr_accessor :reporter, :scheme, :sdk, :workspace, :only, :build_dir

    def initialize
        @cmd = []
    end

    def as_cmd
      "#{XCTOOL} #{_xctool_params} #{@cmd.join(' ')}".gsub(/\s+/, ' ').strip
    end

    def to_s
      "`#{as_cmd}`"
    end

    def append_build_tests
      append_subcommand "build-tests"
      append_subcommand "-only '#{only}'" if only
    end

    def append_run_tests(test_sdk)
      append_subcommand <<-CMD
        run-tests
        -test-sdk '#{test_sdk}'
        -failOnEmptyTestBundles
        -freshSimulator
        -parallelize
        -simulator iphone
      CMD
      @cmd << "-only '#{only}'" if only
    end

    def append_test(test_sdk)
      append_subcommand <<-CMD
        test
        -test-sdk '#{test_sdk}'
        -freshSimulator
        -parallelize
        -failOnEmptyTestBundles
        -simulator iphone
      CMD
      @cmd << "-only '#{only}'" if only
    end

    def append_analyze
      append_subcommand <<-CMD
        analyze
        -failOnWarnings
      CMD
    end

    def append_clean
      append_subcommand "clean"
    end

    def append_build
      append_subcommand "build"
    end

    def append_archive
      append_subcommand "archive"
    end

    private
    def append_subcommand cmd
      @cmd << cmd
    end

    def _xctool_params
      cmd = ""
      cmd << "-reporter '#{@reporter}' \ \n" if @reporter
      cmd << <<-CMD
        -workspace '#{@workspace}' \
        -scheme '#{@scheme}' \
        -sdk '#{@sdk}' \
        -configuration 'Release'
      CMD
      cmd << "BUILD_DIR='#{@build_dir}'" if @build_dir
      cmd
    end
  end
end


module XCTool
  class XCTool
    include Configuration
    attr_accessor :reporter, :scheme, :sdk, :workspace, :only

    def initialize
        @cmd = []
    end

    def as_cmd
      "#{XCTOOL} #{_xctool_params} #{@cmd.join(' ')}".gsub(/\s+/, ' ').strip
    end

    def to_s
      "`#{as_cmd}`"
    end

    def append_subcommand cmd
      @cmd << cmd
    end

    def run_tests(test_sdk)
      @cmd << <<-CMD
        run-tests
        -test-sdk '#{test_sdk}'
        -failOnEmptyTestBundles
        -freshSimulator
        -parallelize
        -simulator iphone
      CMD
      @cmd << "-only '#{only}'" if only
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
      cmd
    end
  end
end


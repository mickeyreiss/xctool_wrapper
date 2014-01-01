require 'spec_helper'

describe XCTool::Builder do
  let(:workspace) { "test_workspace" }
  let(:scheme) { "test_scheme" }

  subject { XCTool::Builder.new(workspace, scheme) }

  describe "initializer" do
    subject { XCTool::Builder.new(workspace, scheme).as_cmd }

    it "should invoke xctool" do
      subject.should start_with("xctool")
    end

    it "should pass given workspace to workspace flag" do
      subject.should include("-workspace '#{workspace}'")
    end

    it "should pass given scheme to scheme flag" do
      subject.should include("-scheme '#{scheme}'")
    end

    it "should include a default sdk" do
      subject.should match(/-sdk '.+'/)
    end

    it "should include a default configuration" do
      subject.should match(/-configuration '(Debug|Release)'/)
    end

    it "should include a default reporter" do
      subject.should include("-reporter '#{XCTool::Configuration::DEFAULT_REPORTER}'")
    end
  end

  describe "#with_reporter" do
    it "should change the reporter" do
      subject.with_reporter("test_reporter").as_cmd.should include("-reporter 'test_reporter'")
    end

    it "should exclude default reporter" do
      subject.with_reporter("test_reporter").as_cmd.should_not include("-reporter '#{XCTool::Configuration::DEFAULT_REPORTER}'")
    end
  end

  describe "#with_target" do
    it "should exclude the target if not specified explicitly" do
      subject.as_cmd.should_not include("-only")
    end

    it "should change the target when running tets" do
      subject.with_target("test_target").run_tests.as_cmd.should include("-only 'test_target'")
    end
  end

  describe "#with_scheme" 

  describe "#with_sdk" 

  describe "#with_all_test_sdks"
  describe "#with_test_sdk"
  describe "#build" do
    it "should append a build subcommand" do
      subject.build.as_cmd.should end_with("build")
    end

    it "should append multiple build subcommands" do
      subject.build.build.build.as_cmd.should end_with("build build build")
    end
  end

  describe "#clean" do
    it "should append a clean subcommand" do
      subject.clean.as_cmd.should end_with("clean")
    end

    it "should append multiple clean subcommands" do
      subject.clean.clean.clean.as_cmd.should end_with("clean clean clean")
    end
  end

  describe "#build_tests" do
    it "should append bulid-tests subcommand" do
      subject.build_tests.as_cmd.should end_with('build-tests')
    end

    it "should append bulid-tests subcommands" do
      subject.build_tests.build_tests.build_tests.as_cmd.should end_with('build-tests build-tests build-tests')
    end
  end

  describe "#run_tests" do
    it "should append a run-tests subcommand with the build sdk" do
      subject.run_tests.as_cmd.should include("run-tests -test-sdk '#{XCTool::Configuration::SDKS.first}'")
    end

    it "should append multiple run-tests subcommands with varying test-sdks" do
      subject.run_tests.with_test_sdk("test_test_sdk").run_tests.as_cmd.should match(/run-tests -test-sdk '#{XCTool::Configuration::SDKS.first}'.*run-tests -test-sdk 'test_test_sdk'/)
    end
  end

  describe "#analyze" do
    it "should append an analyze subcommand" do
      subject.analyze.as_cmd.should include("analyze")
    end

    it "should append multiple analyze analyze subcommands" do
      subject.analyze.analyze.as_cmd.should match(/analyze.*analyze/)
    end
  end

  describe "to_s" do
    it "should return #as_cmd surrounded by backticks" do
      subject.to_s.should eq("`#{subject.as_cmd}`")
    end
  end
end

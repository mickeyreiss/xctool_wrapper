xctool_wrapper
==============

Ruby wrapper around XCTool.

## Basic Usage

```
require 'xctool'
xctool = XCTool::Builder.new("my-workspace", "my-scheme") # instantiate an xctool builder
xctool.with_test_sdk("iphonesimulator7.0").clean.test # configure xctool
sh xctool.as_cmd # you are responsible for shelling out to invoke xctool, located on PATH.
```

## Running the tests

`./ci.sh` or `bundle && rake`.

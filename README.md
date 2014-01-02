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

## Example Implementations

* [Venmo Touch](https://github.braintreeps.com/venmo/venmo-touch-ios-private/blob/9397b0611da70f4d3d00890ae2f8fe188e241238/Rakefile#L75)
* [ios-configuration-management-client](https://github.braintreeps.com/venmo/iOS-Configuration-Management-Client/blob/897d5139227f5c9362431896a04795b3a1c353db/Rakefile#L139)

## Contributing

You should add test coverage and run tests before committing.

### Setup

`bundle`

### Running the tests

`./ci.sh` or `bundle && rake`.

## TODO

* Support all xctool options (e.g. arch is not supported)
* Dynamically support available SDKs
* Tightly couple with xctool versions and invoke xctool

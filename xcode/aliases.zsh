alias simulator='open $(xcode-select -p)/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
simurl() {
    xcrun simctl openurl booted $1
}

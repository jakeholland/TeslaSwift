# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift

target 'TeslaSwift' do
	
	use_frameworks!

	pod 'PromiseKit/CorePromise' , '~> 4.0.0'
	pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :branch => 'swift-3'

	target 'TeslaSwiftTests' do
		
		inherit! :complete
		pod 'OHHTTPStubs', :git => 'https://github.com/AliSoftware/OHHTTPStubs.git', :branch => 'swift-3.0'
		pod 'OHHTTPStubs/Swift', :git => 'https://github.com/AliSoftware/OHHTTPStubs.git', :branch => 'swift-3.0'
		
	end
end

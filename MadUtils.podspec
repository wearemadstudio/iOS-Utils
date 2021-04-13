Pod::Spec.new do |s|
s.name              = 'MadUtils'
s.version           = '0.4.6'
s.summary           = 'Contains a collection of MAD utils'
s.homepage          = 'https://github.com/wearemadru/iOS-Utils'
s.description = <<-DESC
Contains a collection of utils for iOS Apps
DESC
s.ios.deployment_target = '10.0'
s.swift_version = '5.0'
s.license           = { :type => 'MIT', :file => 'LICENSE' }
s.author            = { 'Nick Sadchikov' => 'kolya.s@wearemad.ru' }
s.source            = {
	:git => 'https://github.com/wearemadru/iOS-Utils.git',
	:tag => "#{s.version}" }
s.framework = 'UIKit', 'StoreKit', 'Foundation'
s.source_files      = 'Utils/Utils/Classes/*'
s.dependency 'Alamofire', '~> 5.2'
s.dependency 'Nuke', '~> 8'
end
Pod::Spec.new do |s|
s.name              = 'MadUtils'
s.version           = '0.0.4'
s.summary           = 'Contains a collection of utils'
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
s.framework = "UIKit"
s.source_files      = 'Utils/Utils/UIView/*'
end
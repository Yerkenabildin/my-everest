# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

project 'MyEverest', {
  'Release' => :release,
  'Debug' => :debug,
  'Test' => :debug
}

abstract_target 'abild.in' do
  
  # reactive programming
  pod 'RxSwift', '~>  3.4'
  pod 'RxCocoa', '~>  3.4'
  pod 'RxSwiftExt'

  target 'MyEverest' do
    
    # code style
    pod 'SwiftLint'

    # UI elements
    pod 'IQKeyboardManagerSwift', '~> 4.0'
    pod 'IGColorPicker', '~> 0.2'
    pod 'SCLAlertView', '~> 0.7'
  end

  target 'UnitTests' do

  end
end

# enable tracing resources
#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    if target.name == 'RxSwift'
#      target.build_configurations.each do |config|
#        if config.name == 'Debug'
#          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D',
#          'TRACE_RESOURCES']
#        end
#      end end
#  end end

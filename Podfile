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
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'RxCoreData'
  pod 'RxDataSources'
  pod 'RxAnimated'
  pod 'RxViewController'
  pod 'RxAlamofire'

  target 'MyEverest' do
    
    # code style
    pod 'SwiftLint'

    # UI elements
    pod 'IQKeyboardManagerSwift'
    pod 'R.swift'
    pod 'PopupDialog'
#    pod 'IGColorPicker'
    pod 'SCLAlertView'
    pod 'SnapKit'
    pod 'Kingfisher'


    # Dependency Injection
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    pod 'Sourcery'
  end

  target 'UnitTests' do
    pod 'RxBlocking'
    pod 'Quick'
    pod 'Nimble'
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

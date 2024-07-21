Pod::Spec.new do |s|
  s.name             = "swiftui-hosting-transitions"
  s.version          = "0.1.0"
  s.summary          = "Executing custom matched geometry transitions for UIHostingControllers"
  s.description  = <<-DESC
  When transitioning UIKit projects to SwiftUI, many developers initially wrap their views in UIHostingControllers while keeping navigation in UIKit. However, this approach limits the ability to implement custom transitions between the SwiftUI views. This library addresses this challenge by providing a straightforward solution for executing custom matched geometry transitions specifically designed for UIHostingControllers.
          DESC
  s.homepage         = 'https://github.com/pbalduz/swiftui-hosting-transitions.git'
  s.license          = 'MIT'
  s.author           = { 'Pablo Balduz' => 'https://github.com/pbalduz' }
  s.source           = { :git => 'https://github.com/exyte/ScalingHeaderScrollView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  
  s.requires_arc = true
  s.swift_version = "5.3"

  s.source_files = [
     'Sources/*.swift',
     'Sources/**/*.swift'
  ]
  s.module_name = 'MatchedTransitions'

end

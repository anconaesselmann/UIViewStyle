Pod::Spec.new do |s|
  s.name             = 'UIViewStyle'
  s.version          = '0.1.0'
  s.summary          = 'Style views'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
Style views.
                       DESC

  s.homepage         = 'https://github.com/anconaesselmann/UIViewStyle'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'anconaesselmann' => 'axel@anconaesselmann.com' }
  s.source           = { :git => 'https://github.com/anconaesselmann/UIViewStyle.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'UIViewStyle/Classes/**/*'

  s.frameworks = 'UIKit'
end

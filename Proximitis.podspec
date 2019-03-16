#
# Be sure to run `pod lib lint Proximitis.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Proximitis'
  s.version          = '1.0.0'
  s.summary          = 'SDK for ranging beacons and deliver custom Campaigns.'
  s.description      = 'Framework for ranging Eddystone beacons and deliver custom Campaigns.'
  s.swift_version    = '4.0'

  s.homepage         = 'https://github.com/homoky/proximitis-sdk-ios-public.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'georgnroll' => 'jirka@markalous.cz' }
  s.source           = { :git => 'https://github.com/homoky/proximitis-sdk-ios-public.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Proximitis/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Proximitis' => ['Proximitis/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

   s.dependency 'RealmSwift'

end

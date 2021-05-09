#
# Be sure to run `pod lib lint JBTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JBTextField'
  s.version          = '1.0.0'
  s.summary          = 'Easiest Way to Save Time for Making a Custom TextField.'

  s.homepage         = 'https://github.com/jubakong/JBTextField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "jbK" => 'jubakong@gmail.com' }
  s.source           = { :git => 'https://github.com/jubakong/JBTextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "5.0"
  s.ios.deployment_target = '9.0'

  s.source_files = 'JBTextField/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'JBTextField' => ['JBTextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end

#
# Be sure to run `pod lib lint BLSSignLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BLSSignLib'
  s.version          = '0.1.1'
  s.summary          = 'BLS-381椭圆曲线算法Framework库.'

  s.description      = <<-DESC
  BLS-381椭圆曲线算法Framework库
                       DESC

  s.homepage         = 'https://github.com/lishuailibertine/BLS12-381'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lishuailibertine' => 'lishuai19@yeah.net' }
  s.source           = { :git => 'https://github.com/lishuailibertine/BLS12-381.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.vendored_frameworks ="Frameworks/SLBLSSign.framework"
end

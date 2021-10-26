#
# Be sure to run `pod lib lint RootNleAssembly.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RootNleAssembly'
  s.version          = '0.1.2'
  s.summary          = '基本组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/caojian1235/RootNleAssembly'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'caojian1235' => '404511077@qq.com' }
  s.source           = { :git => 'https://github.com/caojian1235/RootNleAssembly.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'RootNleAssembly/Classes/**/*'
 
  s.subspec 'ZZJsonToModel' do |zzjsonToModel|
     zzjsonToModel.source_files = 'RootNleAssembly/Classes/ZZJsonToModel/**/*'
     
   end
  s.prefix_header_contents = <<-EOS
  #ifdef __OBJC__
  
  #import "YSKDefineMacro.pch"
  
  
  #endif /* __OBJC__*/
  EOS
  # s.resource_bundles = {
  #   'RootNleAssembly' => ['RootNleAssembly/Assets/*.png']
  # }
  s.dependency 'GKNavigationBar'
  s.dependency 'MJRefresh'
  s.dependency 'LYEmptyView'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'MBProgressHUD'
  s.dependency 'YYKit'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

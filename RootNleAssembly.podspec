#
# Be sure to run `pod lib lint RootNleAssembly.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RootNleAssembly'
  s.version          = '0.2.8'
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
#  s.resources = ['RootNleAssembly/Assets/*']
#  s.resource_bundles = {
#     'RootNleAssembly' => ['RootNleAssembly/Assets/*.png']
#   }
  #基本组件
  s.subspec 'BaseVC' do |bvc|
      
      bvc.source_files = 'RootNleAssembly/Classes/BaseVC/**/*'
      bvc.dependency 'GKNavigationBar'
      bvc.dependency 'LYEmptyView'
      bvc.dependency 'Masonry'
      bvc.dependency 'MJRefresh'
      bvc.dependency 'RootNleAssembly/Loading'
      bvc.dependency 'RootNleAssembly/Alert'
      bvc.dependency 'RootNleAssembly/Macro'
      bvc.dependency 'RootNleAssembly/Category'
   end
  #Loading
  s.subspec 'Loading' do |loading|
      
      loading.source_files = 'RootNleAssembly/Classes/Loading/**/*'
      loading.dependency 'Masonry'
      loading.dependency 'YYKit'
      loading.dependency 'MBProgressHUD'
      loading.dependency 'RootNleAssembly/Category'
   end
  #宏
  s.subspec 'Macro' do |ma|
      
      ma.source_files = 'RootNleAssembly/Classes/Macro/**/*'
     
   end
  
  s.subspec 'ZZJsonToModel' do |zz|
      
      zz.source_files = 'RootNleAssembly/Classes/ZZJsonToModel/**/*'
     
   end
  #alert
  s.subspec 'Alert' do |alert|
      alert.source_files = 'RootNleAssembly/Classes/Alert/**/*'
      alert.dependency 'RootNleAssembly/Category'
      alert.dependency 'RootNleAssembly/Macro'
      alert.dependency 'Masonry'
    
      
   end
  #分类
  s.subspec 'Category' do |ca|
      ca.source_files = 'RootNleAssembly/Classes/Category/**/*'
      ca.dependency 'RootNleAssembly/Macro'

      ca.dependency 'MJRefresh'

      ca.dependency 'Masonry'
#      ca.dependency 'SDWebImage'

      ca.dependency 'YYKit'
   end
  #share
  s.subspec 'ShareView' do |shareview|
      shareview.source_files = 'RootNleAssembly/Classes/ShareView/**/*'
      shareview.resources = ['RootNleAssembly/Assets/*']
      shareview.dependency 'RootNleAssembly/Category'
      shareview.dependency 'RootNleAssembly/Macro'
      shareview.dependency 'Toast'
      shareview.dependency 'WechatOpenSDK'
      shareview.dependency 'Masonry'
      shareview.dependency 'YYKit'
   end
#  s.source_files = 'RootNleAssembly/Classes/YSKDefineMacro.pch'
#s.prefix_header_contents = <<-EOS
##ifdef __OBJC__
#
##import "YSKDefineMacro.pch"
#
#
##endif /* __OBJC__*/
#EOS
 

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

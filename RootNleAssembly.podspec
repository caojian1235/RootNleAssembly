#
# Be sure to run `pod lib lint RootNleAssembly.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RootNleAssembly'
  s.version          = '0.3.3'
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
  
  s.resources = ['RootNleAssembly/Assets/*']
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
      bvc.dependency 'ReactiveObjC'
      bvc.dependency 'Toast'
      bvc.dependency 'RootNleAssembly/Common'
      bvc.dependency 'RootNleAssembly/Macro'
      
   end
  s.subspec 'Common' do |com|
      
      
      
      
#      com.source_files = 'RootNleAssembly/Classes/Common/**/*'
      
      #地图跳转
      com.subspec 'JumpMap' do |jump|
          
          jump.source_files = 'RootNleAssembly/Classes/Common/JumpMap/**/*'
          jump.dependency 'AMapLocation'
          
          end
      #弹窗
      com.subspec 'Alert' do |alert|
          
          alert.source_files = 'RootNleAssembly/Classes/Common/Alert/**/*'
          alert.dependency 'RootNleAssembly/Common/Category'
          alert.dependency 'RootNleAssembly/Macro'
          alert.dependency 'Masonry'
          
          end
      
      #分类
      com.subspec 'Category' do |ca|
          ca.source_files = 'RootNleAssembly/Classes/Common/Category/**/*'
          ca.dependency 'RootNleAssembly/Macro'
          ca.dependency 'MJRefresh'
          ca.dependency 'Masonry'
    #      ca.dependency 'SDWebImage'
          ca.dependency 'YYKit'
       end
      #清除缓存
      com.subspec 'ClearCache' do |cc|
          
          cc.source_files = 'RootNleAssembly/Classes/Common/ClearCache/**/*'
          
          end
      
      #Loading
      com.subspec 'Loading' do |loading|
          
          loading.source_files = 'RootNleAssembly/Classes/Common/Loading/**/*'
          
#          loading.subspec 'LoadingGIf' do |loadinggif|
#
#              loading.source_files = 'RootNleAssembly/Classes/Common/Loading/LoadingGIf/**/*'
#
#              end
              
              
          loading.dependency 'Masonry'
          loading.dependency 'YYKit'
          loading.dependency 'SDWebImage'
          loading.dependency 'MBProgressHUD'
          loading.dependency 'RootNleAssembly/Common/Category'
          loading.dependency 'RootNleAssembly/Macro'
          
       end
      #Menu
      com.subspec 'MenuView' do |menu|
          
          menu.source_files = 'RootNleAssembly/Classes/Common/MenuView/**/*'
          
          #          loading.subspec 'LoadingGIf' do |loadinggif|
          #
          #              loading.source_files = 'RootNleAssembly/Classes/Common/Loading/LoadingGIf/**/*'
          #
          #              end
          
          
          menu.dependency 'Masonry'
          menu.dependency 'YYKit'
          menu.dependency 'SDWebImage'
          menu.dependency 'RootNleAssembly/Macro'
          
       end
      
      end
 
  #宏
  s.subspec 'Macro' do |ma|
      
      ma.source_files = 'RootNleAssembly/Classes/Macro/**/*'
     
   end
  
  s.subspec 'ZZJsonToModel' do |zz|
      
      zz.source_files = 'RootNleAssembly/Classes/ZZJsonToModel/**/*'
     
   end


  #share
  s.subspec 'ShareView' do |shareview|
      shareview.source_files = 'RootNleAssembly/Classes/ShareView/**/*'
      shareview.resources = ['RootNleAssembly/Assets/*']
      shareview.dependency 'RootNleAssembly/Common'
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

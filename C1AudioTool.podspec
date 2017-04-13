#
# Be sure to run `pod lib lint C1AudioTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'C1AudioTool'
  s.version          = '0.1.0'
  s.summary          = '一个音频播放工具类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    一个音频播放工具类，支持流式
                       DESC

  s.homepage         = 'https://github.com/Classical1956/C1AudioTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Classical1956' => 'dracula_1956@outlook.com' }
  s.source           = { :git => 'https://github.com/Classical1956/C1AudioTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.platform     = :ios, "8.0"

  s.source_files = 'C1AudioTool/**'
  s.requires_arc = true
  # s.resource_bundles = {
  #   'C1AudioTool' => ['C1AudioTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AudioStreamer'
end

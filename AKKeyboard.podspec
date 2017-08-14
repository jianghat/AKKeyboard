#
#  Be sure to run `pod spec lint AKKeyboard.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "AKKeyboard"
  s.version      = "0.0.1"
  s.summary      = "AKKeyboard."
  s.homepage     = "https://github.com/jianghat/AKKeyboard.git"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "ak" => "549488710@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/jianghat/AKKeyboard.git", :tag => "#{s.version}" }
  s.source_files  = "AKKeyboard", "AKKeyboard/**/*.{h,m}"
  s.resources = "AKKeyboard/AKKeyboard.bundle"
  s.framework  = "UIKit"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end

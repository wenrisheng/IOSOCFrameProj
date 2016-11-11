
Pod::Spec.new do |s|
  s.name         = "IOSOCFrameProj"
  s.version      = "0.0.1"
  s.summary      = "A short description of IOSOCFrameProj."
  s.homepage     = "https://coding.net/u/wrs/p/IOSOCFrameProj/git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.author             = { "wrs" => "252797991@qq.com" }
  # Or just: s.author    = "wrs"
  # s.authors            = { "wrs" => "252797991@qq.com" }
  # s.social_media_url   = "http://twitter.com/wrs"
  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/wenrisheng/IOSOCFrameProj.git", :tag => "#{s.version}" }

  #s.source_files  = "../WSBase/WSBase", "../WSComponents/WSComponents", "../WSService/WSService"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "../WSBase/WSBase", "../WSComponents/WSComponents", "../WSService/WSService"

  # s.resource  = "icon.png"
  s.resources = "../WSComponents/WSComponentsBundle.bundle"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "AFNetworking"
  s.dependency "ASIHTTPRequest"

    s.subspec 'WSBase' do |ss|
        ss.source_files = '../WSBase/WSBase/**/*.{h,m}'
        ss.public_header_files = '../WSBase/WSBase/WSBase.h'
    end
    s.subspec 'WSComponents' do |ss|
        ss.source_files = '../WSComponents/WSComponents/**/*.{h,m}'
        ss.public_header_files = '../WSComponents/WSComponents/WSComponents.h'
        ss.resources = "../WSComponents/WSComponentsBundle.bundle"
    end
    s.subspec 'WSBase' do |ss|
        ss.source_files = '../WSService/WSService/**/*.{h,m}'
        ss.public_header_files = '../WSService/WSService/WSBaseService.h'
    end
end

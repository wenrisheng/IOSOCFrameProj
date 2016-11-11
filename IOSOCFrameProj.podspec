
Pod::Spec.new do |s|
  s.name         = "IOSOCFrameProj"
  s.version      = "0.0.2"
  s.summary      = "A IOSOCFrameProj IOSOCFrameProj."
  s.homepage     = "https://coding.net/u/wrs/p/IOSOCFrameProj/git"
  s.license  = 'MIT'
  s.author             = { "wrs" => "252797991@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/wenrisheng/IOSOCFrameProj.git", :tag => "#{s.version}" }

  s.requires_arc = true

  s.dependency "AFNetworking", '~> 3.1.0'
  s.dependency "ASIHTTPRequest", '~> 1.8.2'

    s.subspec 'WSBase' do |ss|
        ss.source_files = 'WSBase/WSBase/**/**/*.{h,m}'
        ss.public_header_files = 'WSBase/WSBase/WSBase.h'
    end
    s.subspec 'WSComponents' do |ss|
        ss.source_files = 'WSComponents/WSComponents/**/**/*.{h,m}'
        ss.public_header_files = 'WSComponents/WSComponents/WSComponents.h'
ss.resources = "WSComponents/WSComponentsBundle.bundle/*.{png,nib}"
    end
    s.subspec 'WSService' do |ss|
        ss.source_files = 'WSService/WSService/**/**/*.{h,m}'
        ss.public_header_files = 'WSService/WSService/WSBaseService.h'
    end
end

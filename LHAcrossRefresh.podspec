Pod::Spec.new do |s|
  s.name         = "LHAcrossRefresh"
  s.version      = "0.0.2"
  s.summary      = "An useful across refresh components in iOS."
  s.homepage     = "https://github.com/Dreamsouls/LHAcrossRefresh"
  s.license      = "MIT"
  s.author             = { "Dreamsoul" => "a5b322@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Dreamsouls/LHAcrossRefresh.git", :tag => "#{s.version}" }
  s.source_files = "LHAcrossRefresh/**/*.{h,m}"
  s.resource     = 'LHAcrossRefresh/Resource/LHARefresh.bundle'
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
end

Pod::Spec.new do |s|
  s.name             = "FMStretchableHeaderTabViewController"
  s.version          = "0.0.3"
  s.summary          = "Stretchable header view + Horizontal swipable tab view with support for several tabs."
  s.description      = <<-DESC
                       Stretchable header view + Horizontal swipable tab view
                       - Stretchable header view.
                       - Horizontal swipable tab view.
                       - No header tab view.
                       DESC
  s.homepage         = "https://github.com/faridh/FMStretchableHeaderTabViewController"
  s.screenshots      = "https://raw.githubusercontent.com/faridh/FMStretchableHeaderTabViewController/master/Screenshots/screenshot-stretchable.gif", "https://raw.githubusercontent.com/faridh/FMStretchableHeaderTabViewController/master/Screenshots/screenshot-swipable.gif"
  s.license          = 'MIT'
  s.author           = { "Faridh Mendoza" => "faridh.mendoza@gmail.com" }
  s.source           = { :git => "https://github.com/faridh/FMStretchableHeaderTabViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/faridhMendoza'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'
  s.resources = 'Classes/**/*.xib'

  s.ios.exclude_files = 'Classes/osx'
  s.frameworks = 'UIKit', 'CoreGraphics'
end


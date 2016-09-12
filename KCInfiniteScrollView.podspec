

Pod::Spec.new do |s|

  s.name         = "KCInfiniteScrollView"
  s.version      = "1.0.0"
  s.summary      = "A tiny but useful infinite ScrollView with Objective-C."
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "choshoryo" => "kevinzxl1988@gmail.com" }
  s.homepage     = "https://github.com/choshoryo/KCInfiniteScrollView"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/choshoryo/KCInfiniteScrollView.git", :tag => s.version }
  s.source_files = "KCInfiniteScrollView/**/*.{h,m}"
  s.requires_arc = true

end

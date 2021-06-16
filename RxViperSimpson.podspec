Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "RxViperSimpson"
s.summary = "RxViperSimpson shows random simpson quotes using dependency RxSwift and RxAlamofire with VIPER architecture"
s.requires_arc = true

# 2
s.version = "0.1.3"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Faruuq" => "faruuq.q@icloud.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/faruuqq/RxViperSimpson"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/faruuqq/RxViperSimpson.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency "RxAlamofire"
s.dependency "RxCocoa"
s.dependency "SDWebImage"

# 8
s.source_files = "RxViperSimpson/**/*.{swift}"

# 9
s.resources = "RxViperSimpson/**/*.{storyboard,xib}"

# 10
s.swift_version = "5"

end

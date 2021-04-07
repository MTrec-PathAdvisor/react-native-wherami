require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-wherami"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-wherami
                   DESC
  s.homepage     = "https://github.com/hymanae/react-native-wherami"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/hymanae/react-native-wherami.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true
  # s.vendored_framework= 'ios/Frameworks/LBSOfflineSDK.framework'
  s.dependency "React"
  s.dependency 'Mtrec-IOS-LBSOfflineSDK','~>0.0.6'
  # ...
  # s.dependency "..."
end


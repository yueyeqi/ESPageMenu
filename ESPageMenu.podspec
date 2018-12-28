@version = "0.0.1"

Pod::Spec.new do |s| 
s.name = "ESPageMenu" 
s.version = @version
s.summary = "一款Swift好用的PageMenu框架" 
s.description = "一款Swift好用的PageMenu框架,基于UIPageViewController封装"
s.homepage = "https://github.com/yueyeqi/ESPageMenu"
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { "Payne" => "yueyeqi@icloud.com" } 
s.ios.deployment_target = '10.0'
s.source = { :git => "https://github.com/yueyeqi/ESPageMenu.git", :tag => "v#{s.version}" } 
s.source_files = 'ESPageMenu/Code'
s.requires_arc = true 
s.framework = "UIKit"
s.swift_version = '4.0'
end
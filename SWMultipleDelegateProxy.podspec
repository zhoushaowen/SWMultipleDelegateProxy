Pod::Spec.new do |s|

  s.name         = "SWMultipleDelegateProxy"

  s.version      = "0.0.5"

  s.homepage      = 'https://github.com/zhoushaowen/SWMultipleDelegateProxy'

  s.ios.deployment_target = '7.0'

  s.summary      = "a multiple delegate proxy"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWMultipleDelegateProxy.git", :tag => s.version }
  
  s.source_files  = "SWMultipleDelegateProxyDemo/SWMultipleDelegateProxy/*.{h,m}"
  
  s.requires_arc = true



end
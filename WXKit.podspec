Pod::Spec.new do |s|
s.name = 'WXKit'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'WXKit on iOS.'
s.homepage = 'https://github.com/wangxun0618/WXKit.git'
s.authors = { 'wangxun' => 'simonxun@163.com' }
s.source = { :git => 'https://github.com/wangxun0618/WXKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'WXKit/*.{h,m}'
s.resources = 'SXWaveAnimate/images/*.{png,xib}'
end

Pod::Spec.new do |s|
    s.name         = 'WXKit'
    s.version      = '0.0.1'
    s.summary      = 'An easy way to use pull-to-refresh'
    s.homepage     = 'https://github.com/wangxun0618/WXKit'
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.authors      = {'wangxun0618' => 'wangxun@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/wangxun0618/WXKit.git', :tag => s.version}
    s.source_files = 'WXKit/**/*.{h,m}'
    s.requires_arc = true
end
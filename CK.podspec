Pod::Spec.new do |s|
    s.name = 'CK'
    s.version = '0.1.6'
    s.license = { :type => 'AGPL-3.0', :file => 'LICENSE' }
    s.summary = 'An Elegant Content Framework In Swift'
    s.homepage = 'http://www.graphkit.io/'
    s.social_media_url = 'https://www.facebook.com/graphkit'
    s.authors = { 'GraphKit Inc.' => 'support@graphkit.io' }
    s.source = { :git => 'https://github.com/GraphKit/ContentKit.git', :tag => s.version }
    s.ios.deployment_target = '8.0'
    s.source_files = 'Source/*.swift'
    s.requires_arc = true
end

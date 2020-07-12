Pod::Spec.new do |s|
    s.name             = "iCarouselSwift"
    s.version          = "1.0.0"
    s.summary          = "iCarousel的Swift版"
    s.description      = <<-DESC
    iCarouselSwift
    DESC
    s.homepage         = "https://github.com/Z-JaDe"
    s.license          = 'MIT'
    s.author           = { "ZJaDe" => "zjade@outlook.com" }
    s.source           = { :git => "git@github.com:Z-JaDe/iCarouselSwift.git", :tag => s.version.to_s }
    
    s.requires_arc          = true
    
    s.ios.deployment_target = '13.0'
    s.swift_versions        = '5.0','5.1','5.2','5.3'
    s.frameworks            = "Foundation"

    s.source_files          = "Sources/**/*.{swift}"

end

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
    
    s.ios.deployment_target = '10.0'
    s.frameworks            = "Foundation"
    s.swift_version         = "5.0"

    s.source_files          = "Sources/**/*.{swift}"

end

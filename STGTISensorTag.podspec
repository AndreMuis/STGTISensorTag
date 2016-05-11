Pod::Spec.new do |s|
  s.name         = "STGTISensorTag"
  s.version      = "1.0.0"
  s.summary      = "summary"
  s.description  = "description"
  s.homepage     = "https://github.com/AndreMuis/STGTISensorTag"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "AndreMuis"
  s.source       = { :git => "https://github.com/AndreMuis/STGTISensorTag.git", :tag => "1.0.0" }
  s.source_files = "STGTISensorTag/**/*.{swift}"
  s.framework    = "CoreBluetooth"
end

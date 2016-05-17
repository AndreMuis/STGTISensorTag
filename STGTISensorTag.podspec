Pod::Spec.new do |s|
  s.name         			= "STGTISensorTag"
  s.version      			= "1.0.2"
  s.ios.deployment_target 	= '9.0'
  s.tvos.deployment_target 	= '9.0'
  s.summary      			= "iOS framework to interface with the TI Sensor Tag"
  s.description  			= "By adding the STGTISensorTag framework to your iOS app you will be able to enable, configure, read and disable the various sensors on the TI Sensor Tag"
  s.homepage     			= "https://github.com/AndreMuis/STGTISensorTag"
  s.license      			= { :type => "MIT", :file => "LICENSE" }
  s.author       			= "AndreMuis"
  s.source      			= { :git => "https://github.com/AndreMuis/STGTISensorTag.git", :tag => "1.0.2" }
  s.source_files 			= "STGTISensorTag/**/*.{swift}"
  s.framework    			= "CoreBluetooth"
end

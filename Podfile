platform :ios, '13.0'
target 'NavCogKNN' do
	use_frameworks!
        pod 'ImageScrollView'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end


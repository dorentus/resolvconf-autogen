desc "Create a Release build"
task :build do
  sh "xcodebuild -project gw-monitor.xcodeproj -configuration Release SYSMROOT=build"
end

desc "Install a Release build"
task :install => :build do
  if prefix = ENV['prefix']
    bin_dir = File.join(prefix, 'bin')
    mkdir_p bin_dir
    cp "build/Release/gw-monitor", bin_dir
  else
    puts "[!] Specify a directory as the install prefix with the `prefix' env variable"
    exit 1
  end
end

desc "Clean"
task :clean do
  rm_rf "build"
end

require 'rubygems'

def gemspec
  @gemspec ||= begin
    file = File.expand_path("../options-lib.gemspec", __FILE__)
    eval(File.read(file), binding, file)
  end
end

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end

desc "Build gem locally"
task :build => :gemspec do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir_p "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end

desc "Install gem locally"
task :install => :build do
  system "gem install pkg/#{gemspec.name}-#{gemspec.version}"
end

desc "Uninstall gem locally"
task :uninstall => :gemspec do
  system "gem uninstall -x #{gemspec.name}"
end


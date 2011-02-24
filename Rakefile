require 'rubygems'

def gemspec
  @gemspec ||= begin
    file = File.expand_path("../options-lib.gemspec", __FILE__)
    eval(File.read(file), binding, file)
  end
end

def alias_task(old_task, new_task)
    task new_task do
      Rake::Task[old_task].invoke
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

desc "Reinstall gem locally"
task :reinstall do
  Rake::Task[:uninstall].invoke
  Rake::Task[:install].invoke
end

desc "Push gem to RubyGems.org"
task :push do
  system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
end

alias_task(:reinstall, :r)
alias_task(:uninstall, :u)
alias_task(:install, :i)
alias_task(:build, :b)
alias_task(:push, :p)



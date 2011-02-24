Gem::Specification.new do |s|
  s.name    = 'options-lib'
  s.version = '0.9.1'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Options Library'
  s.description = 'A set of classes for dealing with options. It includes a crawler for Yahoo!Finance.'

  s.author   = 'Sergio Oliveira Jr.'
  s.email    = 'sergio.oliveira.jr@gmail.com'
  s.homepage = 'https://github.com/saoj/options-lib'

  # These dependencies are only for people who work on this gem
  s.add_development_dependency 'rspec'
  
  # Runtime dependencies
  s.add_runtime_dependency 'mechanize'

  # The list of files to be contained in the gem
  s.files         = `git ls-files`.split("\n")
  #s.files = s.files - [".gitignore"]
  #s.files = Dir['lib/**/*.rb']
  puts s.files
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
  
  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'
  
  # LOAD_PATH
  #s.require_paths = ['lib']
end

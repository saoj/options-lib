Gem::Specification.new do |s|
  s.name    = 'options-lib'
  s.version = '0.9.3'
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
  s.files         = `git ls-files`.split("\n") - [".gitignore"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  
  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'

end

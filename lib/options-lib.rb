# require all files from options-lib
Dir["./lib/options-lib/**/*.rb"].each { |file| require file.sub("./lib/", "") }

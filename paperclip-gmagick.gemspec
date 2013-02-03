$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'paperclip-gmagick'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-02-03'
  s.summary     = "Paperclip Processor for GMagick"
  s.description = "Call GMagick instead of ImageMagick"
  s.authors     = ["Patrick Mulder"]
  s.email       = 'mulder.patrick@gmail.com'
  s.files       = ["lib/paperclip-gmagick.rb", "lib/paperclip_processors/gmagick.rb"]
  s.homepage    = 'http://github.com/mulderp/paperclip-gmagick'
  s.add_dependency('paperclip')
end

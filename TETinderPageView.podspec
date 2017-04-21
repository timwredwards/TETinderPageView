Pod::Spec.new do |s|

  s.name         = "TETinderPageView"
  s.version      = "0.0.1"
  s.summary      = "An emulation of the page-view style controller used in Tinder"

  s.description  = <<-DESC
  					An emulation of the page-view style controller used in Tinder. This allows you to use a series of view controllers as the contents of a sliding page-view, and also specify an array of icons to use as titles for the pages. Please see the screenshot for more details. 
                   DESC

  s.homepage     = "https://github.com/timwredwards/TETinderPageView"
  s.screenshots  = "https://raw.githubusercontent.com/timwredwards/TETinderPageView/master/img/demo.gif"

  s.license      = "MIT"

  s.author             = { "Timothy Edwards" }
  s.social_media_url   = "http://twitter.com/timwredwards"

  s.platform     = :ios

  s.source       = { :git => "https://github.com/timwredwards/TETinderPageView", :tag => "0.0.1" }

  s.source_files  = "lib", "lib/**/*.{h,m}"
  s.exclude_files = "lib/Exclude"

end

Pod::Spec.new do |s|

  s.name         = "TETinderPageView"
  s.version      = "0.0.1"
  s.summary      = "An emulation of the page-style navigation controller in Tinder"

  s.description  = <<-DESC
                   A longer description of TETinderPageView in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/timwredwards/TETinderPageView"
  s.screenshots  = "https://raw.githubusercontent.com/timwredwards/TETinderPageView/master/img/demo.gif"

  s.license      = "MIT"

  s.author             = { "Timothy Edwards" => "timwredwards@gmail.com" }
  s.social_media_url   = "http://twitter.com/timwredwards"

  s.platform     = :ios

  s.source       = { :git => "https://github.com/timwredwards/TETinderPageView", :tag => "0.0.1" }

  s.source_files  = "lib", "lib/**/*.{h,m}"
  s.exclude_files = "lib/Exclude"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end

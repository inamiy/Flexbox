Pod::Spec.new do |spec|
  spec.name = "Flexbox"
  spec.version = "1.0.0"
  spec.summary = "Swift wrapper of facebook/yoga (CSS Flexbox layout engine)."
  spec.homepage = "https://github.com/inamiy/Flexbox"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "inamiy" => 'inamiy@gmail.com' }
  spec.social_media_url = "http://twitter.com/inamiy"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/TheodoliteGroup/Flexbox.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "{Sources,Externals/yoga/yoga}/**/*.{h,m,mm,c,swift}"
end

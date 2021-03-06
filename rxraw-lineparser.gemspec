Gem::Specification.new do |s|
  s.name = 'rxraw-lineparser'
  s.version = '0.2.0'
  s.summary = 'rxraw-lineparser'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb'] 
  s.signing_key = '../privatekeys/rxraw-lineparser.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/rxraw-lineparser'
  s.required_ruby_version = '>= 2.1.2'
end

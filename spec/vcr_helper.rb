require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr'
  c.hook_into :fakeweb
end

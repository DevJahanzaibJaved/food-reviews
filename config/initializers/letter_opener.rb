# Configure letter_opener for development environment
if Rails.env.development?
  require 'letter_opener'
  
  # Configure letter_opener to open emails in browser
  # On Linux, use 'file://' scheme; on macOS/Windows, 'default' works
  LetterOpener.configure do |config|
    config.file_uri_scheme = 'file://'
    # Store emails in tmp/letter_opener directory
    config.location = Rails.root.join('tmp', 'letter_opener')
  end
end


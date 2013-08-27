
if Rails.env.test? or Rails.env.cucumber?

  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

elsif Rails.env.development?

  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAIMM7II2TX4G4IITQ',                        # required
      :aws_secret_access_key  => '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',                        # required
      :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
      # :host                   => 's3.example.com',             # optional, defaults to nil
      # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'tracker-willinteractive-dev'                     # required
    config.fog_public     = true                                   # optional, defaults to true
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end

else

  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAIMM7II2TX4G4IITQ',                        # required
      :aws_secret_access_key  => '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',                        # required
      :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
      # :host                   => 's3.example.com',             # optional, defaults to nil
      # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'tracker-willinteractive'                     # required
    config.fog_public     = true                                   # optional, defaults to true
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
    
end

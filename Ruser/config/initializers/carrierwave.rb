CarrierWave.configure do |config|
  config.storage = :upyun
   config.upyun_username = Ruser::Setting.upyun_username
   config.upyun_password = Ruser::Setting.upyun_password
   config.upyun_bucket = Ruser::Setting.upyun_bucket
   config.upyun_bucket_domain = Ruser::Setting.upload_url.gsub("http://","")
end

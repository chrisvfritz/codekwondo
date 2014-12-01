Github.configure do |c|
  c.client_id     = Rails.application.secrets[:omniauth][:github][:key]
  c.client_secret = Rails.application.secrets[:omniauth][:github][:secret]
end
module UrlValidations
  extend ActiveSupport::Concern

  included do
    before_validation :format_url
    validate          :valid_url
  end

  def format_url
    self.url = "http://#{self.url}" unless self.url.blank? || self.url[/^https?/]
  end

  def valid_url
    return if url.blank?
    if /(\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z)/ix =~ url
      begin # check header response
        response = Net::HTTP.get_response URI.parse(url)
        return if response.kind_of?(Net::HTTPSuccess) || response.kind_of?(Net::HTTPRedirection)
        message = "doesn't appear to be a page on #{response.uri.host} (#{response.code}: #{response.msg})"
      rescue # Recover on DNS failures
        message = "doesn't seem to exist on the web"
      end
    end
    message ||= "isn't a valid web address"
    errors.add(:url, message)
  end
end
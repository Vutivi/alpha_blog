# app/lib/search.rb

class Search
  ENGINE_NAME = 'blog-search'

  def self.client
    @client ||= SwiftypeAppSearch::Client.new(
      host_identifier: Rails.configuration.x.swiftype.app_search_host_identifier,
      api_key: Rails.configuration.x.swiftype.app_search_api_key,
    )
  end
end

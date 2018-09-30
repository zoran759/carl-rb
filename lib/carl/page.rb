require 'faraday'
require 'faraday_middleware'

module Carl
  class Page

    def self.name
      raise NotImplementedError, "name method is not implemented"
    end

    def self.url
      raise NotImplementedError, "url method is not implemented"
    end

    def self.description
      raise NotImplementedError, "description method is not implemented"
    end

    def up?
      match === true
    end

    def last_fetch
      @last_fetch
    end

    def down?
      !up?
    end

    def self.pages
      descendants = []
      ObjectSpace.each_object(singleton_class) do |k|
        descendants.unshift k unless k == self
      end
      descendants
    end

    private
      def fetch_request
        @fetch_request ||= Faraday.new(self.class.url) do |faraday|
          faraday.use FaradayMiddleware::FollowRedirects
          faraday.adapter Faraday.default_adapter
        end
      end

      def fetch
        return @fetch if @fetch
        @last_fetch = Time.now.utc
        @fetch      = fetch_request.get.body
      end
  end
end

Dir[File.join(File.dirname(__FILE__), "pages", "*.rb")].each do |page|
  require page
end

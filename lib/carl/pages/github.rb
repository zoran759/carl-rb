module Carl
  module Pages
    class Github < Page

      def self.name
        "GitHub"
      end

      def self.url
        "https://status.github.com/api/status.json"
      end

      def self.description
        "GitHub"
      end

      def match
        page = JSON.parse(fetch)
        page["status"] == "good"
      end
    end
  end
end

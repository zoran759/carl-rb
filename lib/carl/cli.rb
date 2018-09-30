require "thor"

module Carl
  class CLI < Thor
    desc "services", "Lists all available services"
    def services
      puts Carl::Page.pages
    end

    desc "fetch", "Fetch current status of available services"
    def fetch
      pages = Carl::Page.pages
      pages.each do |page|
        puts Render.new(page.new).get
      end
    end
  end
end

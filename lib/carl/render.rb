module Carl
  class Render
    def initialize(page)
      @page = page
    end

    def get
      "[#{@page.class.name}] #{@page.up? ? 'Up' : 'Down'}"
    end

  end
end

class V2::TeaFacade
  class << self
    def fetch_teas
      format_teas(TeaClient.fetch('/tea'))
    end

    private

    def format_teas(teas)
      teas.map do |tea|
        TeaPoro.new(tea)
      end
    end
  end
end

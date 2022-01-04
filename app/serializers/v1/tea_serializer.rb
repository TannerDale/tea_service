module V1::TeaSerializer
  class << self
    def serialize(teas)
      {
        teas: format_teas(teas)
      }
    end

    private

    def format_teas(teas)
      teas.map do |tea|
        format(tea)
      end
    end

    def format(tea)
      {
        id: tea.id,
        title: tea.title,
        temperature: tea.temperature,
        description: tea.description,
        brew_time: tea.brew_time
      }
    end
  end
end

class TeaPoro
  attr_reader :id, :title, :description, :brew_time, :temperature

  def initialize(tea)
    @id = tea[:_id]
    @title = tea[:name]
    @description = tea[:description]
    @brew_time = tea[:brew_time].to_i
    @temperature = tea[:temperature].to_i
  end
end

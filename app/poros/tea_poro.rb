class TeaPoro
  attr_reader :id, :name, :description, :brew_time, :temperature

  def initialize(tea)
    @id = tea[:_id]
    @name = tea[:name]
    @description = tea[:description]
    @brew_time = tea[:brew_time].to_i
    @temperature = tea[:temperature].to_i
  end
end

class Api::V1::TeasController < ApplicationController
  def index
    render json: V1::TeaSerializer.serialize(Tea.all)
  end
end

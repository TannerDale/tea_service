class Api::V2::TeasController < ApplicationController
  def index
    render json: V1::TeaSerializer.serialize(V2::TeaFacade.fetch_teas)
  end
end

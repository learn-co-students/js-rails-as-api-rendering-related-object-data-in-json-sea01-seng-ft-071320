class SightingsController < ApplicationController
  def show
    sighting = Sighting.includes(:bird, :location).find_by(id: params[:id])
    if !!sighting
      render json: sighting.to_json(
        include: {
          bird: { only: [ :name, :species ] },
          location: { only: [ :latitude, :longitude ] }
        },
        only: [ :id, :bird, :location ]
      )
    else
      render json: { message: "Sighting not found by that id" }
    end
  end
end

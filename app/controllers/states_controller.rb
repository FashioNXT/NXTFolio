class StatesController < ApplicationController
    def index
        @states = State.where(country_id: params[:country_id])
        respond_to do |format|
            format.json { render json: @states }
        end
    end
end

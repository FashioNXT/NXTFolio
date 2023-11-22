# class CitiesController < ApplicationController
#     def index
#         @cities = City.where(state_id: params[:state_id]).order(:name)

#         respond_to do |format|
#             format.json { render json: @cities }
#         end
#     end
# end

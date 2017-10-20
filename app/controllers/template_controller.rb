class TemplateController < ApplicationController
  def create
    flash[:notice] = "successfully created."
    type = params[:prof_name]
    attributes1 = params.select { |key, value| key.to_s.match(/^field_*/) }
    field_name_arr = params[:field_name]
    field_type_arr = params[:field_type]

    #puts "printing attributes", params[:field_name]
    field_name_arr.each_with_index do |field_name, index|
      puts "printing key",field_name
      puts "printing value",field_type_arr[index]
    end

    professional = Template.create(prof_name: type, attributes: attributes1)
    #params = ActionController::Parameters.new(prof_name: type, attributes: attributes1)
    #Template.new(params.permit(:prof_name,:attributes))
    professionals = Template.all
  end

  # Params used to create the LoginInfo object
  def template_params
    params.require(:prof_name).permit(:attributes)
  end
 
  # Associated with x`the view used for create
  def new
  end
  
  def index
  end 
end


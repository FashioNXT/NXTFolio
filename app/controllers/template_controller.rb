class TemplateController < ApplicationController
  def create
    flash[:notice] = "successfully created."
    type = params[:prof_name]
    attributes1 = params.select { |key, value| key.to_s.match(/^field_*/) }
    keys = params[:attribute]
    puts "printing atteributes", field
    keys.each_with_index do |key, value|
      puts "printing key",key
      puts "printing value",value
    end
    puts "data-type", type
    puts "data-attributes1", attributes1
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


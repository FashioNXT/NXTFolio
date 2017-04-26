class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # def self.remove
  #   if LoginInfo.exists?
  #     LoginInfo.find(session[:current_user_key]).destroy
  #     GeneralInfo.find(session[:current_user_key]).destroy
      
  #     if SpecificDesigner.exists?
  #       SpecificDesigner.find(session[:current_user_key]).destroy
  #     elsif SpecificModel.exists?
  #       SpecificModel.find(session[:current_user_key]).destroy
  #     elsif SpecificPhotographer.exists?
  #       SpecificPhotographer.find(session[:current_user_key]).destroy
  #     end
  #   end
  # end
end

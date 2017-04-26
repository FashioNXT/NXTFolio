class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def self.remove
    if LoginInfo.exists?
      LoginInfo.find(params[:userKey]).destroy
      GeneralInfo.find(params[:userKey]).destroy
      
      if SpecificDesigner.exists?
        SpecificDesigner.find(params[:userKey]).destroy
      elsif SpecificModel.exists?
        SpecificModel.find(params[:userKey]).destroy
      elsif SpecificPhotographer.exists?
        SpecificPhotographer.find(params[:userKey]).destroy
      end
    end
  end
end

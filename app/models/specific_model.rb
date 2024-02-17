 class SpecificModel < ApplicationRecord
   attr_accessor :allgenres

   #params_arg are the params returned from the SpecificModel search but DOES NOT INCLUDE GENRE
   def self.search general_info_user_keys, params_arg
     @final_return = []

     if params_arg.length > 0
       GeneralInfo.all.find_each do |user_object|

         if user_object[:specific_profile_id] == 2
           spec_object = SpecificModel.find_by(user_key: user_object["userKey"])
           puts spec_object.inspect

           incl = true
           params_arg.each do |param_key, param_val|
             if param_key == "checkboxes" || param_key == "min_dress_size"
               next
             end

             if param_key == "max_height" || param_key == "min_height"
               model_height_ft = 0
               model_height_in = 0

               if spec_object["height_feet"] != nil
                 model_height_ft = spec_object["height_feet"]
               end

               if spec_object["height_inches"] != nil
                 model_height_in = spec_object["height_inches"]
               end

               model_height_tot = (model_height_ft * 12) + model_height_in

               min_height = 0
               max_height = 99999

               if params_arg.include? "min_height"
                 min_height = params_arg["min_height"].to_f
               end

               if params_arg.include? "max_height"
                 max_height = params_arg["max_height"].to_f
               end

               if model_height_tot < (min_height * 12) || model_height_tot > (max_height * 12)
                 incl = false
               end

               if model_height_tot == 0
                 incl = false
               end
             elsif param_key == "max_dress_size" || param_key == "min_dress_size"
               model_dress_size = 0

               if spec_object["dress_size"] != nil
                 model_dress_size = spec_object["dress_size"]
               end

               min_size = 0
               max_size = 99999
               if params_arg.include? "min_dress_size"
                 min_size = params_arg["min_dress_size"].to_i
               end

               if params_arg.include? "max_dress_size"
                 max_size = params_arg["max_dress_size"].to_i
               end

               puts min_size
               puts max_size
               puts model_dress_size
               if model_dress_size < min_size || model_dress_size > max_size
                 incl = false
               end

               if model_dress_size == 0
                 incl = false
               end
             else

               chk_val = user_object[param_key]

               if chk_val == nil
                puts param_key
                chk_val = spec_object[param_key]
               end

               if chk_val != param_val
                incl = false
               end
             end
           end

           # GENRE CHECKING

           if params_arg["checkboxes"] && incl && spec_object["genre"]
             genre_arr = spec_object["genre"].split(",")

             puts genre_arr

             genre_incl = false
             params_arg["checkboxes"].each do |genre|
               if genre_arr.include? genre
                 puts genre
                 genre_incl = true
               end
             end

             incl = genre_incl
           end

           if incl
             @final_return.push(user_object[:userKey])
           end
         end
       end
     else
       GeneralInfo.all.find_each do |user_object|
         if user_object[:specific_profile_id] == 2
           @final_return.push(user_object[:userKey])
         end
       end
     end

     return @final_return
   end

   # Sets appearance of profile view attributes
   def attribute_values
     @attribute_values = Hash.new
     @attribute_values[:height] = "Height: " + self.height_feet.to_s + " ft. " + self.height_inches.to_s + " in."
     @attribute_values[:bust] = "Bust size: " + self.bust.to_s + " in."
     @attribute_values[:waist] = "Waist size: " + self.bust.to_s + " in."
     @attribute_values[:hips] = "Hips size: " + self.hips.to_s + " in."
     @attribute_values[:cups] = "Cup size: " + self.cups.to_s
     @attribute_values[:shoe_size] = "Shoe size: " + self.shoe_size.to_s
     @attribute_values[:dress_size] = "Dress size: " + self.dress_size.to_s
     @attribute_values[:hair_color] = "Hair color: " + self.hair_color.to_s
     @attribute_values[:eye_color] = "Eye color: " + self.eye_color.to_s
     @attribute_values[:ethnicity] = "Ethnicity: " + self.ethnicity.to_s
     @attribute_values[:skin_color] = "Skin color: " + self.skin_color.to_s
     @attribute_values[:shoot_nudes] = "Shoots nudes: " + self.shoot_nudes.to_s
     @attribute_values[:tattoos] = "Has tattoos: " + self.tattoos.to_s
     @attribute_values[:piercings] = "Piercings: " + self.piercings.to_s
     @attribute_values[:experience] = "Experience: " + self.experience.to_s

     @attribute_values[:genre] = "Genre: "
     if self.genre != nil
       self.genre.split(",").each do |genre|
         @attribute_values[:genre] += genre + ", "
       end
       @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length-2]
     end

     @attribute_values
   end
 end

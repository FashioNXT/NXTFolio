# class SpecificPhotographer < ApplicationRecord
#   attr_accessor :allgenres

#   def self.search general_info_user_keys, params_arg
#     @final_return = []

#     if params_arg.length > 0
#       GeneralInfo.all.find_each do |user_object|

#         if user_object[:specific_profile_id] == 3
#           spec_object = SpecificPhotographer.find_by(user_key: user_object["userKey"])

#           puts spec_object.inspect

#           incl = true
#           params_arg.each do |param_key, param_val|
#             if param_key == "checkboxes"
#               next
#             end

#             chk_val = user_object[param_key]

#             if chk_val == nil
#               puts param_key
#               chk_val = spec_object[param_key]
#             end

#             if chk_val != param_val
#               incl = false
#             end
#           end

#           # GENRE CHECKING

#           if spec_object
#             if params_arg["checkboxes"] && incl && spec_object["genre"]
#               genre_arr = spec_object["genre"].split(",")

#               puts genre_arr

#               genre_incl = false
#               params_arg["checkboxes"].each do |genre|
#                 if genre_arr.include? genre
#                   puts genre
#                   genre_incl = true
#                 end
#               end

#               incl = genre_incl
#             else
#               incl = false
#             end

#             if incl
#               @final_return.push(user_object[:userKey])
#             end
#           else
#             incl = false
#           end
#         end
#       end
#     else
#       GeneralInfo.all.find_each do |user_object|
#         if user_object[:specific_profile_id] == 3
#           @final_return.push(user_object[:userKey])
#         end
#       end
#     end

#     return @final_return
#   end

#   # Sets appearance of profile view attributes
#   def attribute_values
#     @attribute_values = Hash.new
#     @attribute_values[:influencers] = "Influencers: " + self.influencers.to_s
#     @attribute_values[:specialties] = "Specialities: " + self.specialties.to_s
#     @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s
#     @attribute_values[:experience] = "Experience: " + self.experience.to_s

#     @attribute_values[:genre] = "Genre(s): "
#     if self.genre != nil
#       self.genre.split(",").each do |genre|
#         @attribute_values[:genre] += genre + ", "
#       end
#       @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length-2]
#     end

#     @attribute_values
#   end
# end

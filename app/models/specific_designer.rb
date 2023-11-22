# class SpecificDesigner < ApplicationRecord
#   attr_accessor :allgenres

#   def self.search checkboxes, general_info_user_keys, experience_arg, params_arg
#     @user_array = Array.new
#     @genre_checked_array = Array.new
#     @return_array = Array.new
#     @experience_str = params_arg[:experiece]

#     # Search based on the room keys retrieved from GeneralInfo, store into @user_array
#     if (general_info_user_keys.length > 0)
#       # Gets here if general_info_user_keys has entries
#       general_info_user_keys.each do |user_key_element|
#         if SpecificDesigner.exists?(user_key: user_key_element)
#           @user_array.push(SpecificDesigner.find_by(user_key: user_key_element))
#         end
#       end
#     else
#       # Gets here if nothing came through general_info_user_keys
#     end

#     # Genre requires a slightly different search
#     # For every room in user_array, check if A genre matches ANY genre
#     # If there are no genres, loop through @user_array & push the keys into @genre_checked_array
#     if checkboxes.nil?
#       # Gets here if genre is empty
#       # Leave genre checked hash empty since we're not searching for genres
#     elsif !(@user_array.length > 0)
#       # They did not search for anything in GeneralInfo and room array never got populated,
#       # Therefore they are looking for everyone in the profession, using genres
#       SpecificDesigner.all.find_each do |user_object|
#         checkboxes.each do |key, checkbox_genre|
#           if user_object[:genre].to_s.include? key.to_s
#             @genre_checked_array.push(user_object)
#             break
#           end
#         end
#       end
#     else
#       # Gets here if user_array has entries
#       @user_array.each do |user_object|
#         checkboxes.each do |key, checkbox_genre|
#           if user_object[:genre].to_s.include? key.to_s
#             @genre_checked_array.push(user_object)
#             break
#           end
#         end
#       end
#     end

#     # 1st check that there are any params worth searching
#     if !experience_arg.nil?
#       if(@genre_checked_array.length > 0)
#         # Can search by experience & previous genre-checked results
#         @genre_checked_array.each do |user_object|
#           if SpecificDesigner.where("user_key ILIKE ? AND experience ILIKE ?)" , user_object[:user_key], @experiece_arg)
#             @return_array.push(user_object[:user_key])
#           end
#         end
#       else
#         # Can search by experience but have no previous genre-checked results
#         # Search entire model and check for the params
#         SpecificDesigner.all.find_each do |user_object|
#           if SpecificDesigner.where("user_key ILIKE ?", user_object[:user_key])
#             @return_array.push(user_object[:user_key])   #Might need to find by instead... very worse in efficiency tbh.
#           end
#         end
#       end
#     else
#       if(@genre_checked_array.length > 0)
#         # Have no experience to search by but have genre-checks
#         # Return genre-checked results
#         @genre_checked_array.each do |user_object|
#           @return_array.push(user_object[:user_key])
#         end
#       else
#         # Have no experience to search by and no genre-checked results
#         # Return everything in the table
#         SpecificDesigner.all.find_each do |user_object|
#           @return_array.push(user_object[:user_key])
#         end
#       end
#     end

#     return @return_array
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

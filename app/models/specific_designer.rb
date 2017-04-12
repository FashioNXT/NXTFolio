class SpecificDesigner < ApplicationRecord
    #belongs_to :general_info
    attr_accessor :allgenres
    
  def self.search checkboxes, user_keys_array, experience_arg, params_arg
    @user_array = Array.new
    @genre_checked_array = Array.new
    @return_array = Array.new
    @experience_str = params_arg[:experiece]
    
    puts "SPECIFIC DESIGNER - MODEL"
    puts general_info_user_keys.size
    # Search based on the user keys we got from general info, store into @user_array
    if (general_info_user_keys.length > 0)
      puts "SPECIFIC DESIGNER - MODEL -  general_info_user_keys has a few entries"
      general_info_user_keys.each do |user_key_element|
        puts user_key_element.to_s
        if SpecificModel.exists?(user_key: user_key_element)
          @user_array.push(SpecificModel.find_by(user_key: user_key_element))
        end
      end
    else
      puts "SPECIFIC DESIGNER - MODEL - ELSE, this means nothing came through general_info_user_keys"
    end
    
    # For every user in user_array, check if A genre matches ANY genre. 
    # If there are no genres , loop through @user_array, push the key into @genre_checked_array
    if checkboxes.nil?
      puts "SPECIFIC DESIGNER - MODEL : GENRES ARE EMPTY"
      #Leave genre checked hash empty as we are not searching for genres.
    elsif !(@user_array.length > 0)
      puts "SPECIFIC DESIGNER - MODEL : USER_ARRAY IS EMPTY(General Info didn't have any searches), but we do have genres to search by"
      #They did not search for anything in General Info and user array never got populated, 
      #therefore they are looking for everyone in the profession.
      SpecificModel.all.find_each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    else
      puts "SPECIFIC DESIGNER - MODEL : GENRE ELSE, User Array has a few entries."
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    end
    
    puts "After genre check, the size is..."
    puts @genre_checked_array.size
    
    #First check that we even have any params worth searching
    if params_arg[:height_feet].to_s != '' || params_arg[:height_inch].to_s != '' || params_arg[:dress_size].to_s != '' || params_arg[:hair_color].to_s != ''  || params_arg[:skin_color].to_s != ''  || params_arg[:shoot_nudes].to_s != ''  || params_arg[:piercings].to_s != ''  || params_arg[:experience].to_s != '' 
      if(@genre_checked_array.length > 0)
        puts "FINAL STEP - We have specific params to search by, and we had previous genre-checked results"
        @genre_checked_array.each do |user_object|
          if SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ? OR dress_size ILIKE ? OR hair_color ILIKE ? OR skin_color ILIKE ? OR shoot_nudes ILIKE ? OR tattoos ILIKE ? OR piercings ILIKE ? OR experience ILIKE ?)" , user_object[:user_key], params_arg[:height_feet], params_arg[:height_inches], params_arg[:dress_size], params_arg[:hair_color], params_arg[:skin_color], params_arg[:shoot_nudes], params_arg[:tattoos], params_arg[:piercings], params_arg[:experience])
            @return_array.push(SpecificModel.find_by(user_key: user_object[:user_key]))
          end
        end
      else
        puts "FINAL STEP - We have params to search by, but no genre matches previously. Search entire model and check for the params"
        SpecificModel.all.find_each do |user_object|
          if SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ? OR dress_size ILIKE ? OR hair_color ILIKE ? OR skin_color ILIKE ? OR shoot_nudes ILIKE ? OR tattoos ILIKE ? OR piercings ILIKE ? OR experience ILIKE ?)" , user_object[:user_key], params_arg[:height_feet], params_arg[:height_inches], params_arg[:dress_size], params_arg[:hair_color], params_arg[:skin_color], params_arg[:shoot_nudes], params_arg[:tattoos], params_arg[:piercings], params_arg[:experience])
            @return_array.push(user_object)   #Might need to find by instead... very worse in efficiency tbh.
          end
        end
      end
    else
      puts "FINAL STEP - We DO NOT have specific params to search by, but we had genre-checks. Return them."
      if(@genre_checked_array.length > 0)
        @return_array = @genre_checked_array
      else
        puts "FINAL STEP - We DO NOT have specific params to search by, and we DO NOT have genres... Return everything in the table..."
        SpecificModel.all.find_each do |user_object|
          @return_array.push(user_object) 
        end
      end
    end
    
    ###########################################################################
    # Search based on the user keys, store into @user_array
    user_keys_array.each do |user_key_element|
      if SpecificDesigner.exists?(user_key: user_key_element)
        @user_array.push(SpecificDesigner.find_by(user_key: user_key_element))
      end
    end
    
    if params_arg[:genre].nil?
      @genre_checked_hash = user_keys_array 
    else
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_hash.push(user_object)
            break
          end
        end
      end
    end
    
    # passed genre test
    @genre_checked_hash.each do |user_object|
      if user_object[:experience].to_s == experience_arg.to_s
        @return_array.push(user_object)
      else
        @return_array = @genre_checked_hash
      end
    end
    puts @return_array.size
    
  end
  

  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:influencers] = "Influencers: " + self.influencers.to_s
    @attribute_values[:specialties] = "Specialities: " + self.specialties.to_s
    @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s
    @attribute_values[:experience] = "Experience: " + self.experience.to_s
    
    @attribute_values[:genre] = "Genre(s): "
    self.genre.split(",").each do |genre|
      @attribute_values[:genre] += genre + ", "
    end
    @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length-2]
    
    @attribute_values
  end
end

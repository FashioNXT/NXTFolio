class SpecificModel < ApplicationRecord
  attr_accessor :allgenres
  
  #params_arg are the params returned from the SpecificModel search but DOES NOT INCLUDE GENRE
  def self.search general_info_user_keys, checkboxes, params_arg
    @user_array = Array.new
    @genre_checked_array = Array.new
    @return_array = Array.new
    @priority_hash = Hash.new
    @priority_return_array = Array.new
    
    # Search based on the user keys we got from GeneralInfo, store into @user_array
    if (!general_info_user_keys.nil? && general_info_user_keys.length > 0)
      # Gets here if general_info_user_keys has entries
      general_info_user_keys.each do |user_key_element|
        puts user_key_element.to_s
        if SpecificModel.exists?(user_key: user_key_element)
          @user_array.push(SpecificModel.find_by(user_key: user_key_element))
        end
        
        if !(@user_array.length > 0)
          return @priority_return_array
        end     
      end
    else
      # Gets here if nothing came through general_info_user_keys
      @user_array = SpecificModel.all
    end
    
    # If it was an empty search, go ahead and return @user if there was one
    if (checkboxes.nil? && params_arg.values.all? {|x| !x.nil?} && @user_array.length > 0)
      @user_array.each do |user_object|
        @priority_return_array.push(user_object[:user_key])
      end
      
      return @priority_return_array
    end
    
    # Genre requires a slightly different search. 
    # For every user in user_array, check if A genre matches ANY genre 
    # If there are no genres, loop through @user_array & push the keys into @genre_checked_array
    if checkboxes.nil?
      # Gets here if genre is empty
      # Leave genre checked hash empty as we are not searching for genres.
    elsif !(@user_array.length > 0)
      #They did not search for anything in GeneralInfo and user array never got populated, 
      # Therefore they are looking for everyone in the profession, using genres
      SpecificModel.all.find_each do |user_object| 
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    else
      # Gets here if user_array has entries
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          @user_genre_str = String.new
          @key_str = String.new
          @user_genre_str = user_object[:genre]
          @key_str = key.to_s
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    end
    
    # 1st check that there are any params worth searching
    if params_arg[:height_feet].to_s != '' || params_arg[:height_inch].to_s != '' || params_arg[:dress_size].to_s != '' || params_arg[:hair_color].to_s != ''  || params_arg[:skin_color].to_s != ''  || params_arg[:shoot_nudes].to_s != ''  || params_arg[:piercings].to_s != ''  || params_arg[:experience].to_s != '' 
      if(@genre_checked_array.length > 0)
        # Can search by specific params & previous genre-checked results
        @genre_checked_array.each do |user_object|
          if SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ? OR dress_size ILIKE ? OR hair_color ILIKE ? OR skin_color ILIKE ? OR shoot_nudes ILIKE ? OR tattoos ILIKE ? OR piercings ILIKE ? OR experience ILIKE ?)" , user_object[:user_key], params_arg[:height_feet], params_arg[:height_inches], params_arg[:dress_size], params_arg[:hair_color], params_arg[:skin_color], params_arg[:shoot_nudes], params_arg[:tattoos], params_arg[:piercings], params_arg[:experience])
            @return_array.push(user_object[:user_key])
          end
        end
      else
        # Can search by experience but have no previous genre-checked results
        # Search entire model and check for the params
        SpecificModel.all.find_each do |user_object|
          if SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ? OR dress_size ILIKE ? OR hair_color ILIKE ? OR skin_color ILIKE ? OR shoot_nudes ILIKE ? OR tattoos ILIKE ? OR piercings ILIKE ? OR experience ILIKE ?)" , user_object[:user_key], params_arg[:height_feet], params_arg[:height_inches], params_arg[:dress_size], params_arg[:hair_color], params_arg[:skin_color], params_arg[:shoot_nudes], params_arg[:tattoos], params_arg[:piercings], params_arg[:experience])
            @return_array.push(user_object[:user_key])   #Might need to find by instead... worse in efficiency to do that though
          end
        end
      end
    else
      if(@genre_checked_array.length > 0)
        # Have no specific params to search by but have genre-checks
        # Return genre-checked results
        @genre_checked_array.each do |user_object|
          @return_array.push(user_object[:user_key])
        end
      else
        # Have no specific params to search by and no genre-checked results
        # Return everything in the table
        SpecificModel.all.find_each do |user_object|
          @return_array.push(user_object[:user_key]) 
        end
      end
    end
   
   # Ranks users by how closely they matched the search params
    @return_array.each do |user_key|
      @priority_counter = 0
      @user = SpecificModel.find_by(user_key: user_key)
      
      if !checkboxes.nil?
        checkboxes.each do |key, checkbox_genre|
          if @user[:genre].to_s.include? key.to_s
            @priority_counter = @priority_counter + 1
          end
        end
      end

      if @user[:experience] == params_arg[:experience]
        @priority_counter = @priority_counter + 1
      end
      
      if (@user[:height_feet] == params_arg[:height_feet] && @user[:height_inches] == params_arg[:height_inches])
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:dress_size] == params_arg[:dress_size] 
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:skin_color] == params_arg[:skin_color] 
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:shoot_nude] == params_arg[:shoot_nude] 
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:hair_color] == params_arg[:hair_color] 
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:tattoos] == params_arg[:tattos] 
        @priority_counter = @priority_counter + 1
      end
      
      if @user[:piercings] == params_arg[:piercings] 
        @priority_counter = @priority_counter + 1
      end
      
      @priority_hash.store(@user[:user_key], @priority_counter)
    end
    
    @priority_hash = @priority_hash.sort_by {|k,v| v}.reverse
    
    @priority_hash.each do |user_key, value|
      @priority_return_array.push(user_key)
    end
    
    @users = @priority_return_array

    @final_return = []

    if params_arg.length > 0
      GeneralInfo.all.find_each do |user_object|
        if user_object[:specific_profile_id] == 1
          puts user_object.inspect

          incl = true
          params_arg.each do |param_key, param_val|
            if user_object[param_key] != param_val
              incl = false
            end
          end

          if incl
            @final_return.push(user_object[:userKey])
          end
        end
      end
    else
      return @priority_return_array
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
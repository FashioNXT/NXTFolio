class SpecificDesigner < ApplicationRecord
    #belongs_to :general_info
    attr_accessor :allgenres
    
def self.search checkboxes, general_info_user_keys, experience_arg, params_arg
    @user_array = Array.new
    @genre_checked_array = Array.new
    @return_array = Array.new
    @experience_str = params_arg[:experiece]
    @priority_hash = Hash.new
    @priority_return_array = Array.new
    
    puts "SPECIFIC DESIGNER - MODEL"
    # Search based on the user keys we got from general info, store into @user_array
    if (!general_info_user_keys.nil? && general_info_user_keys.length > 0)
      puts "SPECIFIC DESIGNER - MODEL -  general_info_user_keys has a few entries"
      general_info_user_keys.each do |user_key_element|
        puts user_key_element.to_s
        if SpecificDesigner.exists?(user_key: user_key_element)
          @user_array.push(SpecificDesigner.find_by(user_key: user_key_element))
        end
        if !(@user_array.length > 0)
          return @priority_return_array
        end   
      end
    else
      puts "SPECIFIC DESIGNER - MODEL - ELSE, this means nothing came through general_info_user_keys"
        @user_array = SpecificDesigner.all
    end
    
    #If it was an empty search, go ahead and return @user if there was one.
    if (checkboxes.nil? && params_arg.values.all? {|x| !x.nil?} && @user_array.length > 0)
      @user_array.each do |user_object|
        @priority_return_array.push(user_object[:user_key])
      end
      
      return @priority_return_array
    end
    
    # Genre requires a bit of a different search. For every user in user_array, check if A genre matches ANY genre. 
    # If there are no genres , loop through @user_array, push the keys into @genre_checked_array
    if checkboxes.nil?
      puts "SPECIFIC DESIGNER - MODEL : GENRES ARE EMPTY"
      #Leave genre checked hash empty as we are not searching for genres.
    elsif !(@user_array.length > 0)
      puts "SPECIFIC DESIGNER - MODEL : USER_ARRAY IS EMPTY(General Info didn't have any searches), but we do have genres to search by"
      #They did not search for anything in General Info and user array never got populated, 
      #therefore they are looking for everyone in the profession.
      SpecificDesigner.all.find_each do |user_object| 
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
          puts "First user, then the search key"
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
    
    puts "After genre check, the size is..."
    puts @genre_checked_array.size
    
    #First check that we even have any params worth searching
    if params_arg[:experience] != ''
      if(@genre_checked_array.length > 0)
        puts "FINAL STEP - We have experience to search by, and we had previous genre-checked results"
        @genre_checked_array.each do |user_object|
          if SpecificDesigner.where("user_key ILIKE ? AND experience ILIKE ?)" , user_object[:user_key], @experiece_arg)
            @return_array.push(user_object[:user_key])
          end
        end
      else
        puts "FINAL STEP - We have experience to search by, but no genre matches previously. Search entire model and check for the params"
        SpecificDesigner.all.find_each do |user_object|
          if params_arg[:experience] == user_object[:experience]
            @return_array.push(user_object[:user_key])
          end
        end
      end
    else
      if(@genre_checked_array.length > 0)
        puts "FINAL STEP - We DO NOT have experience to search by, but we had genre-checks. Return them."
        @genre_checked_array.each do |user_object|
          @return_array.push(user_object[:user_key])
        end
      else
        puts "FINAL STEP - We DO NOT have experience to search by, and we DO NOT have genres... Return everything in the table..."
        if (checkboxes.nil? || params_arg.nil?)
          SpecificDesigner.all.find_each do |user_object|
            @return_array.push(user_object[:user_key]) 
          end
        end
      end
    end
    
    #Ranking users for how closely they matched the search params.
    @return_array.each do |user_key|
      @priority_counter = 0
      @user = SpecificDesigner.find_by(user_key: user_key)
      
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
      
      @priority_hash.store(@user[:user_key], @priority_counter)
    end
    
    @priority_hash = @priority_hash.sort_by {|k,v| v}.reverse
    
    @priority_hash.each do |user_key, value|
      @priority_return_array.push(user_key)
    end
    
    return @priority_return_array
  end
  

  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:influencers] = "Influencers: " + self.influencers.to_s
    @attribute_values[:specialties] = "Specialities: " + self.specialties.to_s
    @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s
    @attribute_values[:experience] = "Experience: " + self.experience.to_s
    
    @attribute_values[:genre] = "Genre(s): "
    if self.genre != nil
      self.genre.split(",").each do |genre|
        @attribute_values[:genre] += genre + ", "
      end
      @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length-2]
    end
    
    @attribute_values
  end
end

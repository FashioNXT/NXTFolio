class SpecificModel < ApplicationRecord
  #belongs_to :general_info
  attr_accessor :allgenres
  
  def self.search user_keys_array, checkboxes, params_arg
    @user_array = Array.new
    @genre_checked_array = Array.new
    @return_array = Array.new
    
    # Search based on the user keys, store into @user_array
    user_keys_array.each do |user_key_element|
      if SpecificModel.exists?(user_key: user_key_element)
        puts "ONCE"
        @user_array.push(SpecificModel.find_by(user_key: user_key_element))
      end
    end
    
    # For every user in user_array, check if A genre matches ANY genre. 
    #If there are no genres , loop through @user_array, push the key into @genre_checked_array
    if params_arg[:genre].nil?
      @genre_checked_array = user_keys_array 
    else
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object[:user_key])
            break
          end
        end
      end
    end
    
    
    
    puts "COOL THINGS GENRE CHECKED"
    puts @genre_checked_array.size
    # passed genre test
    @genre_checked_array.each do |user_key|
      if !params_arg[:height_feet].nil? || !params_arg[:height_inch].nil? || !params_arg[:dress_size].nil? || !params_arg[:hair_color].nil? || !params_arg[:skin_color].nil? || !params_arg[:shoot_nudes].nil? || !params_arg[:piercings].nil? || !params_arg[:experience].nil?  
        if SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ? OR dress_size ILIKE ? OR hair_color ILIKE ? OR skin_color ILIKE ? OR shoot_nudes ILIKE ? OR tattoos ILIKE ? OR piercings ILIKE ? OR experience ILIKE ?)" , user_key, params_arg[:height_feet], params_arg[:height_inches], params_arg[:dress_size], params_arg[:hair_color], params_arg[:skin_color], params_arg[:shoot_nudes], params_arg[:tattoos], params_arg[:piercings], params_arg[:experience])
          @return_array.push(user_key)
        end
      else
        @return_array = @genre_checked_array
      end
    end
    
    # Now we have the user_keys that have passed the genre test.
    # Use these keys in a .where to specify the search for only them. 
    # Example: SpecificModel.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ?)", searchArg[:user_key], searchArg[:height_feet], searchArg[:height_inches])
    puts "AAAAAAAAAAAAAAAAAA"
    puts @return_array.size
    puts @return_array[0].to_s
    puts @return_array[1].to_s
    
    
  end
  
  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:height] = "Height: " + self.height_feet.to_s + " ft. " + self.height_inches.to_s + " in."
    @attribute_values[:test] = "ttttt: " + self.height_feet.to_s + " ft. " + self.height_inches.to_s + " in."
    @attribute_values
  end
end
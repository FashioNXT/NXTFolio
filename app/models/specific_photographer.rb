class SpecificPhotographer < ApplicationRecord
    #belongs_to :general_info
    attr_accessor :allgenres
    
  def self.search checkboxes, user_keys_array, experience_arg, params_arg
    @user_array = Array.new
    @genre_checked_hash = Array.new
    @return_array = Array.new
    @experience_str = params_arg[:experiece]
    
    puts "8888888888888888888888888888888888"

    # Search based on the user keys, store into @user_array
    user_keys_array.each do |user_key_element|
      if SpecificPhotographer.exists?(user_key: user_key_element)
        @user_array.push(SpecificPhotographer.find_by(user_key: user_key_element))
      end
    end
    
    # For every user in user_array, check if A genre matches ANY genre. 
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
    
    
    # For each element in @return_array, check if that object matches the experiece
    @genre_checked_hash.each do |user_object|
      # If that object's experience == experience_arg, Then it's allll gucci
      if user_object[:experience].to_s == experience_arg.to_s
        @return_array.push(user_object)
      else
        @return_array = @genre_checked_hash
      end
    end
    
    return @return_array
    # Now we have the user_keys that have passed the genre test.
    # Use these keys in a .where to specify the search for only them. 
    # Example: SpecificPhotographer.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ?)", searchArg[:user_key], searchArg[:height_feet], searchArg[:height_inches])
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

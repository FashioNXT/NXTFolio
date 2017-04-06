class SpecificDesigner < ApplicationRecord
    #belongs_to :general_info
    attr_accessor :allgenres
    
  def self.search checkboxes, user_keys_array, experience_arg
    @user_array = Array.new
    @genre_checked_hash = Array.new
    @return_array = Array.new
    
    # Search based on the user keys, store into @user_array
    user_keys_array.each do |user_key_element|
      if SpecificDesigner.exists?(user_key: user_key_element)
        @user_array.push(SpecificDesigner.find_by(user_key: user_key_element))
      end
    end
    
    if params_arg[:genre].nil?
      @genre_checked_array = user_keys_array 
    else
       # For every user in user_array, check if A genre matches ANY genre. 
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
        if user_object[:genre].to_s.include? key.to_s
          @genre_checked_hash.push(user_object[:user_key])
          break
    end
    
   
    
    # passed genre test
    # For each element in @return_array, check if that object matches the experiece
    @genre_checked_hash.each do |user_key_in_array|
      if SpecificDesigner.find_by(user_key: user_key_in_array)[:experience].to_s == experience_arg.to_s
        puts SpecificDesigner.find_by(user_key: user_key_in_array)[:experience].to_s
        @return_array.push(user_key_in_array)
      end
    end
      
    
    puts @return_array.size
    # Now we have the user_keys that have passed the genre test.
    # Use these keys in a .where to specify the search for only them. 
    # Example: SpecificPhotographer.where("user_key ILIKE ? AND (height_feet ILIKE ? OR height_inch ILIKE ?)", searchArg[:user_key], searchArg[:height_feet], searchArg[:height_inches])

  end
end

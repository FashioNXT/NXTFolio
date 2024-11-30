class SpecificDesigner < ApplicationRecord
  attr_accessor :allgenres

  def self.search(checkboxes, general_info_user_keys, experience_arg)
    @user_array = fetch_user_array(general_info_user_keys)
    @genre_checked_array = fetch_genre_checked_array(@user_array, checkboxes)
    @return_array = fetch_return_array(@genre_checked_array, experience_arg)
    @return_array
  end

  # Sets appearance of profile view attributes
  def attribute_values
    # Define attributes to be processed
    attributes = {
      influencers: "Influencers: ",
      specialties: "Specialities: ",
      compensation: "Compensation: ",
      experience: "Experience: "
    }
    
    # Initialize the attribute values hash
    @attribute_values = {}

    # Loop through each attribute and assign its value
    attributes.each do |key, label|
      @attribute_values[key] = "#{label}#{self[key].to_s}"
    end
    
    # Handle genre attribute separately
    @attribute_values[:genre] = "Genre(s): "
    if self.genre.present?
      @attribute_values[:genre] += self.genre.split(",").map(&:strip).join(", ")
    end

    @attribute_values
  end

  private

  def self.fetch_user_array(general_info_user_keys)
    user_array = []
    general_info_user_keys.each do |user_key_element|
      user = SpecificDesigner.find_by(user_key: user_key_element)
      user_array.push(user) if user
    end
    user_array
  end

  def self.fetch_genre_checked_array(user_array, checkboxes)
    genre_checked_array = []

    if checkboxes.nil?
      # No genres to search, leave genre_checked_array empty
    elsif user_array.empty?
      SpecificDesigner.all.find_each do |user_object|
        if checkboxes.keys.any? { |key| user_object[:genre].to_s.include?(key.to_s) }
          genre_checked_array.push(user_object)
        end
      end
    else
      user_array.each do |user_object|
        if checkboxes.keys.any? { |key| user_object[:genre].to_s.include?(key.to_s) }
          genre_checked_array.push(user_object)
        end
      end
    end

    genre_checked_array
  end

  def self.fetch_return_array(genre_checked_array, experience_arg)
    return_array = []

    if experience_arg.present?
      if genre_checked_array.any?
        genre_checked_array.each do |user_object|
          if SpecificDesigner.where("user_key ILIKE ? AND experience ILIKE ?", user_object[:user_key], experience_arg).exists?
            return_array.push(user_object[:user_key])
          end
        end
      else
        SpecificDesigner.all.find_each do |user_object|
          if SpecificDesigner.where("user_key ILIKE ?", user_object[:user_key]).exists?
            return_array.push(user_object[:user_key])
          end
        end
      end
    elsif genre_checked_array.any?
      genre_checked_array.each { |user_object| return_array.push(user_object[:user_key]) }
    else
      SpecificDesigner.all.find_each { |user_object| return_array.push(user_object[:user_key]) }
    end

    return_array
  end
 end


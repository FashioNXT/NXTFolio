class SpecificPhotographer < ApplicationRecord
  attr_accessor :allgenres

  def self.search(params_arg)
    @final_return = []

    if params_arg.empty?
      # Handle the no-parameters case explicitly
      GeneralInfo.where(specific_profile_id: 3).find_each do |user_object|
        @final_return.push(user_object[:userKey])
      end
      return @final_return
    end

    GeneralInfo.where(specific_profile_id: 3).find_each do |user_object|
      spec_object = SpecificPhotographer.find_by(user_key: user_object["userKey"])
      next unless spec_object

      if params_match?(params_arg, user_object, spec_object) &&
         genre_match?(params_arg["checkboxes"], spec_object["genre"])
        @final_return.push(user_object[:userKey])
      end
    end

    @final_return
  end

  # Checks if user attributes and params match
  def self.params_match?(params_arg, user_object, spec_object)
    params_arg.all? do |param_key, param_val|
      next true if param_key == "checkboxes"

      chk_val = user_object[param_key] || spec_object[param_key]
      chk_val == param_val
    end
  end

  # Checks if genres match
  def self.genre_match?(checkboxes, genre_string)
    return true unless checkboxes
    return false unless genre_string

    genre_arr = genre_string.split(",")
    checkboxes.any? { |genre| genre_arr.include?(genre) }
  end

  def attribute_values
    {
      influencers: "Influencers: #{influencers}",
      specialties: "Specialities: #{specialties}",
      compensation: "Compensation: #{compensation}",
      experience: "Experience: #{experience}",
      genre: format_genres
    }
  end

  private

  def format_genres
    return "Genre(s): " unless genre

    genre_list = genre.split(",").map(&:strip).join(", ")
    "Genre(s): #{genre_list}"
  end
end
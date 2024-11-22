class SpecificModel < ApplicationRecord
  attr_accessor :allgenres

  def self.search(params_arg)
    @final_return = []

    if params_arg.length > 0
      GeneralInfo.all.find_each do |user_object|
        next unless user_object[:specific_profile_id] == 2

        spec_object = SpecificModel.find_by(user_key: user_object["userKey"])
        next unless spec_object

        incl = validate_params(params_arg, user_object, spec_object)
        incl &&= genre_check(params_arg["checkboxes"], spec_object["genre"]) if params_arg["checkboxes"]

        @final_return.push(user_object[:userKey]) if incl
      end
    else
      find_all_users
    end

    @final_return
  end

  # Validate params other than genre
  def self.validate_params(params_arg, user_object, spec_object)
    params_arg.each do |param_key, param_val|
      next if ["checkboxes", "min_dress_size"].include?(param_key)

      case param_key
      when "max_height", "min_height"
        return false unless validate_height(params_arg, spec_object)
      when "max_dress_size", "min_dress_size"
        return false unless validate_dress_size(params_arg, spec_object)
      else
        chk_val = user_object[param_key] || spec_object[param_key]
        return false if chk_val != param_val
      end
    end
    true
  end

  # Validate height range
  def self.validate_height(params_arg, spec_object)
    model_height = (spec_object["height_feet"].to_i * 12) + spec_object["height_inches"].to_i
    return false if model_height.zero?

    min_height = params_arg["min_height"].to_f * 12 || 0
    max_height = params_arg["max_height"].to_f * 12 || Float::INFINITY
    model_height.between?(min_height, max_height)
  end

  # Validate dress size range
  def self.validate_dress_size(params_arg, spec_object)
    model_dress_size = spec_object["dress_size"].to_i
    return false if model_dress_size.zero?

    min_size = params_arg["min_dress_size"].to_i || 0
    max_size = params_arg["max_dress_size"].to_i || Float::INFINITY
    model_dress_size.between?(min_size, max_size)
  end

  # Validate genres
  def self.genre_check(checkboxes, genre_string)
    return false unless genre_string

    genre_arr = genre_string.split(",")
    checkboxes.any? { |genre| genre_arr.include?(genre) }
  end

  # Find all users with specific_profile_id == 2
  def self.find_all_users
    GeneralInfo.all.find_each do |user_object|
      @final_return.push(user_object[:userKey]) if user_object[:specific_profile_id] == 2
    end
  end

  # Sets appearance of profile view attributes
  def attribute_values
    @attribute_values = {
      height: "Height: #{height_feet} ft. #{height_inches} in.",
      bust: "Bust size: #{bust} in.",
      waist: "Waist size: #{waist} in.",
      hips: "Hips size: #{hips} in.",
      cups: "Cup size: #{cups}",
      shoe_size: "Shoe size: #{shoe_size}",
      dress_size: "Dress size: #{dress_size}",
      hair_color: "Hair color: #{hair_color}",
      eye_color: "Eye color: #{eye_color}",
      ethnicity: "Ethnicity: #{ethnicity}",
      skin_color: "Skin color: #{skin_color}",
      shoot_nudes: "Shoots nudes: #{shoot_nudes}",
      tattoos: "Has tattoos: #{tattoos}",
      piercings: "Piercings: #{piercings}",
      experience: "Experience: #{experience}",
      genre: format_genres
    }
  end

  # Format genres
  def format_genres
    return "Genre: " unless genre

    genres = genre.split(",").join(", ")
    "Genre: #{genres}"
  end
end

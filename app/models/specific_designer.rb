class SpecificDesigner < ApplicationRecord
  attr_accessor :allgenres
    
  def self.search general_info_user_keys, params_arg, job
    @final_return = []

    if params_arg.length > 0
      GeneralInfo.all.find_each do |user_object|
        puts "here"
        puts user_object.inspect
        puts "here"
        puts params_arg.inspect

        incl = true
        params_arg.each do |arg, val|
          i = 0
          job.constantize.view_Attr().each do |title|
            if title == arg
              if val != user_object[:job_attr][i]
                incl = false
              end
            end
          end
        end

          # GENRE CHECKING

          if params_arg["checkboxes"] && incl && spec_object["genre"]
            genre_arr = spec_object["genre"].split(",")

            puts genre_arr

            genre_incl = false
            params_arg["checkboxes"].each do |genre|
              if genre_arr.include? genre
                puts genre
                genre_incl = true
              end
            end

            incl = genre_incl
          end

          if incl
            @final_return.push(user_object[:userKey])
          end
        end
    else
      GeneralInfo.all.find_each do |user_object|
        if user_object[:job_name] == job
          @final_return.push(user_object[:userKey])
        end
      end
    end

    return @final_return
  end
  
  # Sets appearance of profile view attributes
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

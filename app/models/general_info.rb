class GeneralInfo < ApplicationRecord
    has_one :login_info
    validates_presence_of :first_name
    validates_presence_of :last_name
    validates_presence_of :phone
    validates_presence_of :month_ofbirth
    validates_presence_of :day_ofbirth
    validates_presence_of :year_ofbirth
    validates_presence_of :country
    validates_presence_of :state
    validates_presence_of :city
    #validates_presence_of :job_name
    serialize :job_attr, Hash
    

    validates :phone, numericality: true

    mount_uploader :profile_picture, AvatarUploader
    mount_uploader :cover_picture, CoverUploader
    mount_uploaders :gallery_pictures, GalleryUploader

    geocoded_by :address
    after_validation :geocode

    attr_accessor :phone
    
    def address
      [city, state, country].compact.join(", ")
    end

  def self.search searchArg
    location = nil
    if searchArg[:location].present? and searchArg[:location] != ''
      location = searchArg[:location]
    end

    distance = 20
    if searchArg[:distance].present? and searchArg[:distance] != ''
      distance = Integer(searchArg[:distance])
    end

    if location != nil
      query = GeneralInfo.near(location, distance)
    else
      query = GeneralInfo.all
    end

    if searchArg[:first_name].present?
      if searchArg[:first_name_regex] == 'Contains'
        searchArg[:first_name] = "%" + searchArg[:first_name] + "%"
      elsif searchArg[:first_name_regex] == 'Starts With'
        searchArg[:first_name] = searchArg[:first_name] + "%"
      elsif searchArg[:first_name_regex] == 'Ends With'
        searchArg[:first_name] = "%" + searchArg[:first_name]
      elsif searchArg[:first_name_regex] == 'Exactly Matches'
        searchArg[:first_name] = searchArg[:first_name]
      end
      query = query.where("first_name ILIKE ?", searchArg[:first_name])
    end

    if searchArg[:last_name].present?
      if searchArg[:last_name_regex]=='Contains'
        searchArg[:last_name]="%"+searchArg[:last_name]+"%"
      elsif searchArg[:last_name_regex]=='Starts With'
        searchArg[:last_name]=searchArg[:last_name]+"%"
      elsif searchArg[:last_name_regex]=='Ends With'
        searchArg[:last_name]="%"+searchArg[:last_name]
      elsif searchArg[:last_name_regex]=='Exactly Matches'
        searchArg[:last_name]=searchArg[:last_name]
      end
      query = query.where("last_name ILIKE ?", searchArg[:last_name])
    end

    if searchArg[:gender].present? and searchArg[:gender] != 'Any'
      query = query.where("gender ILIKE ?", searchArg[:gender])
    end


    if searchArg[:compensation].present? and searchArg[:compensation] != 'Any'
      searchArg[:compensation]="%"+searchArg[:compensation]+"%"
      query = query.where("compensation ILIKE ?", searchArg[:compensation])
    end

    return query
  end
  
  # Sets appearance of profile view attributes
  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:name] = "Name: " + self.first_name.to_s + " " + self.last_name.to_s
    @attribute_values[:phone]= "Phone: "+self.phone.to_s
    @attribute_values[:birthday] = "Birthday: " + self.month_ofbirth.to_s + " / " + self.day_ofbirth.to_s + " / " + self.year_ofbirth.to_s  
    @attribute_values[:gender] = "Gender: " + self.gender.to_s
    @attribute_values[:location] = "Location: " + self.city.to_s + ", " + self.state.to_s + ", " + self.country.to_s
    @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s 
    @attribute_values[:facebook_link] = "Facebook: " + self.facebook_link.to_s
    @attribute_values[:linkedIn_link] = "LinkedIn: " + self.linkedIn_link.to_s
    @attribute_values[:instagram_link] = "Instagram: " + self.instagram_link.to_s
    @attribute_values[:personalWebsite_link] = "Personal website: " + self.personalWebsite_link.to_s
    @attribute_values[:bio] = "Biography: " + self.bio.to_s
    @attribute_values[:job_name] = self.job_name.to_s
    @attribute_values[:job_attr] = self.job_attr
    @attribute_values
  end

  # Create/Define Jobs by dynamically creating classes

  @@AcceptableAttrTypes = ["Integer", "Float", "String"]
  
  @@Job_List = Array.new
  @@Job_Attr = Hash.new
  @@Attr_Type = Hash.new
  # Need code to populate job based off of existing database (For server reboots)

  def self.see_Jobs
    @@Job_List
  end

  def self.see_Types
    @@AcceptableAttrTypes
  end
  
  def self.check_Job?(jobName)
    @@Job_List.include?(jobName)
  end

  def self.delete_Job(jobName)
    if (self.check_Job?(jobName))
      @@Job_List.delete(jobName)
      
      # Code here to edit the database entries
    end
  end

  def self.delete_Job_From_File(job_Name)
    if(File.exists?("jobList.dat"))
      File.readlines("jobList.dat").each do |line|
        file_cont = File.read ("jobList.dat")
        new_cont = file_cont.gsub(/^(#{Regexp.escape(job_Name)}).*/, "")
        File.open("jobList.dat", "w") {|file| file.puts new_cont}
      end
    end
  end
  
  def self.load_Job_File()
    
    if(File.exists?("jobList.dat"))
      File.readlines("jobList.dat").each do |line|
        classMatch = line.match(/^([A-Z]\w*)/)
        eachAttrMatch = line.to_enum(:scan, /\w+(\s\w+)*(%)/).map {Regexp.last_match}
        eachTypeMatch = line.to_enum(:scan, /\w+(\s\w+)*(,|')/).map {Regexp.last_match}
        eachAttrMatch = eachAttrMatch.flatten
        eachTypeMatch = eachTypeMatch.flatten
        if(classMatch.to_s != nil && classMatch.to_s != "")
          self.create_Job(classMatch.to_s, false)
          if(eachAttrMatch != nil && eachAttrMatch.size > 0)
            x = 0
            while (x < eachAttrMatch.size)
              classMatch.to_s.constantize.add_Attr(eachAttrMatch[x].to_s.chop, eachAttrMatch[x].to_s.chop)
              x = x + 1
            end
          end
        end
      end
    end
  end

  def self.create_Job (className, writeToFile = true)

    # Code to validate the job name has chars only will go here
    
    if(self.check_Job?(className.upcase_first) == false)
      @@Job_List.push(className.upcase_first)
      @@Job_Attr[className.upcase_first] = Array.new
      @@Attr_Type[className.upcase_first] = Array.new

      # Create entry in Job File List
      
      creator = Object.const_set(className.upcase_first, Class.new { 

       
        
        def self.display_Name()
          self.name
        end

        def display_Name()
          self.display_Name()
        end
  
       # def initialize()

       # end
   
        def self.add_Attr(attr_Name, attr_Type = "String")
          # If Name not in hash already
          if(@@Job_Attr[self.name].include?(attr_Name) == false)
            @@Job_Attr[self.name].push(attr_Name)
            @@Attr_Type[self.name].push(attr_Type)
            self.update_File
          end
          # Else Error, name already exists
        end

        def add_Attr(attr_Name, attr_Type = "String")
           self.add_Attr(attr_Name, attr_Type)
        end
    
        def self.edit_Attr(attr_Name, new_Name, new_Type = nil)
          indexLoc = @@Job_Attr[self.name].find_index(attr_Name)

          if(indexLoc)
            @@Job_Attr[self.name][indexLoc] = new_Name
            if(new_type != nil)
              @@Attr_Type[self.name] = new_Type
            end
            self.update_File
            # Code to run through database and edit all existing entries 
          end
        end

        def edit_Attr(attr_Name, new_Name, new_Type = nil)
           self.edit_Attr(attr_Name, new_Name, new_Type)
        end
        
        def self.delete_Attr(attr_Name)
          indexLoc = @@Job_Attr[self.name].find_index(attr_Name)
  
          if(indexLoc)
            @@Job_Attr[self.name].delete_at(indexLoc)
            @@Attr_Type[self.name].delete_at(indexLoc)
            self.update_File
            # Code to shift all attributes into place in database
          end
        end

        def delete_Attr(attr_Name)
          self.delete_Attr(attr_Name)
        end
    
        def self.view_Attr()
          @@Job_Attr[self.name]
        end

        def view_Attr()
          self.view_Attr()
        end

        def self.view_Attr_Type(attr_Name)
          indexLoc = @@Attr_Type[self.name].find_index(attr_Name)

          if(indexLoc)
            @@Attr_Type[self.name][indexLoc]
          else
            nil
          end
        end

        def view_Attr_Type(attr_Name)
          self.view_Attr_Type(attr_Name)
        end
        
        def self.update_File()
          self_Name = self.display_Name
          attr_Body = '\''
          x = 0
          while(x < @@Job_Attr[self.name].size)
            attr_Body = attr_Body + @@Job_Attr[self.name][x] +'%'+ @@Attr_Type[self.name][x] +'\''
            x = x + 1
          end
          if(attr_Body == '\'')
            attr_Body = '\'\''
          end
          new_line = self.display_Name + " " + attr_Body
          file_cont = File.read ("jobList.dat")
          new_cont = file_cont.gsub(/^(#{Regexp.escape(self_Name)}).*/, new_line)
          File.open("jobList.dat", "w") {|file| file.puts new_cont}
        end

        def update_File()
          self.update_File()
        end
        
      })

      if(writeToFile)
        if(File.exists?("jobList.dat") == false)
          jobFile = File.open("jobList.dat", "w+") do |line|
            line.puts creator.display_Name + " " + ("'#{creator.view_Attr.join("','")}'")
          end
        else
          jobFile = File.open("jobList.dat", "a") do |line|
            line.puts creator.display_Name + " " + ("'#{creator.view_Attr.join("','")}'")
          end
        end
      end
    end
  end
end

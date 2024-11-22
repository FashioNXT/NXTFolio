class GeneralInfo < ApplicationRecord
  has_many :gallery, dependent: :destroy, foreign_key: 'GeneralInfo_id' 
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :login_info

  # For follow feature
  has_many(:follows, :foreign_key => :followee, :dependent => :destroy)
  has_many(:follows_from, :class_name => :Follow,
      :foreign_key => :follower, :dependent => :destroy)
  has_many :followers, :through => :follows, :source => :follower
  has_many :follows_others, :through => :follows_from, :source => :followee

  # NXTFolio : Added in Spring 2023 for tagging feature
  has_many :gallery_taggings
  has_many :tagged_gallery, through: :gallery_taggings, source: :gallery

  # List of all collaborators our user has collaborated with
  has_many :collaborations, foreign_key: :general_info_id
  has_many :collaborators, through: :collaborations, source: :collaborator
  
  validates_length_of   :highlights, :minimum => 1
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :company
  validates_presence_of :industry
  validates_presence_of :highlights
  validates_presence_of :country
  validates_presence_of :state
  validates_presence_of :city
  validates_presence_of :emailaddr
  # validates_presence_of :job_name
  serialize :job_attr, Hash


  # validates :phone, numericality: true

  mount_uploader :profile_picture, AvatarUploader
  mount_uploader :cover_picture, CoverUploader
  mount_uploaders :gallery_pictures, GalleryUploader

  geocoded_by :address
  after_validation :geocode

  def address
    [city, state, country].compact.join(", ")
  end

  # def name
  #   self[:name]
  # end

  def self.search(searchArg)
    location = searchArg[:location].presence
    distance = searchArg[:distance].presence ? Integer(searchArg[:distance]) : 20
    query = location ? GeneralInfo.near(location, distance) : GeneralInfo.all
  
    query = apply_text_filter(query, searchArg[:first_name], searchArg[:first_name_regex], "first_name") if searchArg[:first_name].present?
    query = apply_text_filter(query, searchArg[:last_name], searchArg[:last_name_regex], "last_name") if searchArg[:last_name].present?
  
    query = apply_direct_filter(query, searchArg[:gender], "gender") if searchArg[:gender].present? && searchArg[:gender] != 'Any'
    query = apply_direct_filter(query, searchArg[:compensation], "compensation", wildcard: true) if searchArg[:compensation].present? && searchArg[:compensation] != 'Any'
    query = apply_direct_filter(query, searchArg[:job_type], "job_name") if searchArg[:job_type].present? && searchArg[:job_type] != 'Any'
  
    query
  end
  
  private_class_method def self.apply_text_filter(query, value, regex, column)
    case regex
    when 'Contains'
      value = "%#{value}%"
    when 'Starts With'
      value = "#{value}%"
    when 'Ends With'
      value = "%#{value}"
    when 'Exactly Matches'
      value = value
    end
    query.where("#{column} ILIKE ?", value)
  end
  
  private_class_method def self.apply_direct_filter(query, value, column, wildcard: false)
    value = "%#{value}%" if wildcard
    query.where("#{column} ILIKE ?", value)
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
    jobList = @@Job_List
    jobList.delete('Admin')
    jobList
  end

  def self.see_Types
    @@AcceptableAttrTypes
  end

  def self.check_Job?(jobName)
    if(jobName == 'Admin')
      false
    else
      @@Job_List.include?(jobName)
    end
  end

  def self.delete_Job(jobName)
    if (self.check_Job?(jobName))
      @@Job_List.delete(jobName)
      jobString = '\''
      @@Job_List.each do |job|
        jobString = jobString + job + '\''
      end
      $redis.set('jobList', jobString)
      $redis.del(jobName)

      # Code here to edit the database entries
    end
  end


  def self.load_Job_File
    jobString = $redis.get('jobList')
    
    if jobString.present?
      load_jobs_from_redis(jobString)
    else
      initialize_admin_role
    end
  end
  
  private_class_method def self.load_jobs_from_redis(jobString)
    jobArray = jobString.scan(/\w+/)
    
    jobArray.each do |job|
      load_job_attributes(job)
    end
  end
  
  private_class_method def self.load_job_attributes(job)
    attrString = $redis.get(job)
    
    return if attrString.nil? 
  
    eachAttrMatch = extract_attributes(attrString)
    eachTypeMatch = extract_types(attrString)
  
    self.create_Job(job, false)
    
    if eachAttrMatch.any?
      eachAttrMatch.each do |attr|
        job.constantize.add_Attr(attr.to_s.chop, "String", false)
      end
      job.constantize.update_File
    end
  end
  
  private_class_method def self.extract_attributes(attrString)
    attrString.to_enum(:scan, /\w+(\s\w+)*(%)/).map { Regexp.last_match }.flatten
  end
  
  private_class_method def self.extract_types(attrString)
    attrString.to_enum(:scan, /\w+(\s\w+)*(,|')/).map { Regexp.last_match }.flatten
  end
  
  private_class_method def self.initialize_admin_role
    $redis.set('jobList', 'Admin')
    $redis.set('Admin', '')
    self.create_Job('Admin', false)
  end  

  def self.create_Job(className, writeToFile = true)
    # Return early if job already exists or if it's 'Admin' or 'admin'
    return if self.check_Job?(className.upcase_first) || className.downcase == 'admin'
  
    # Initialize job with empty attributes
    initialize_job(className)
  
    # Create the class dynamically
    creator = create_job_class(className)
  
    # Update Redis with the new job list
    update_job_list_to_redis(className) if writeToFile
  end
  
  # Initialize the job attributes and list
  private_class_method def self.initialize_job(className)
    @@Job_List.push(className.upcase_first)
    @@Job_Attr[className.upcase_first] = []
    @@Attr_Type[className.upcase_first] = []
  end
  
  # Dynamically create the job class with the necessary methods
  private_class_method def self.create_job_class(className)
    Object.const_set(className.upcase_first, Class.new {
      # Add methods to the job class
      def self.display_Name
        self.name
      end
  
      def self.add_Attr(attr_Name, attr_Type = "String", writeToRedis = true)
        return if @@Job_Attr[self.name].include?(attr_Name)
  
        @@Job_Attr[self.name].push(attr_Name)
        @@Attr_Type[self.name].push(attr_Type)
  
        update_File if writeToRedis
      end
  
      def self.edit_Attr(attr_Name, new_Name, new_Type = nil)
        indexLoc = @@Job_Attr[self.name].find_index(attr_Name)
        return unless indexLoc
  
        @@Job_Attr[self.name][indexLoc] = new_Name
        @@Attr_Type[self.name] = new_Type if new_Type
  
        update_File
      end
  
      def self.delete_Attr(attr_Name)
        indexLoc = @@Job_Attr[self.name].find_index(attr_Name)
        return unless indexLoc
  
        @@Job_Attr[self.name].delete_at(indexLoc)
        @@Attr_Type[self.name].delete_at(indexLoc)
  
        update_File
      end
  
      def self.view_Attr
        @@Job_Attr[self.name]
      end
  
      def self.view_Attr_Type(attr_Name = nil)
        return @@Attr_Type[self.name] unless attr_Name
  
        indexLoc = @@Attr_Type[self.name].find_index(attr_Name)
        indexLoc ? @@Attr_Type[self.name][indexLoc] : nil
      end
  
      def self.update_File
        attr_Body = "'" + build_attr_body
        $redis.set(self.name, attr_Body)
      end
  
      private
  
      def self.build_attr_body
        @@Job_Attr[self.name].each_with_index.map do |attr, index|
          "#{attr}%#{@@Attr_Type[self.name][index]}"
        end.join("'")
      end
    })
  end
  
  # Update the job list in Redis
  private_class_method def self.update_job_list_to_redis(className)
    jobString = @@Job_List.map { |job| "'#{job}'" }.join
    $redis.set('jobList', "'#{jobString}'")
    $redis.set(className.upcase_first, '')
  end  

  def follow(id)
    followee = GeneralInfo.find(id)
    Follow.create!(:follower => self, :followee => followee)
  end

  def unfollow(id)
    followee = GeneralInfo.find(id)
    self.follows_others.delete(followee)
  end

  def get_followers 
     self.followers
  end

  def get_users_they_follow
     self.follows_others
  end

  def self.filterBy(country, state, profession, city)
    filtered_by_profession = filter_by_profession(profession)
    filtered_by_country = filter_by_country(filtered_by_profession, country)
    filtered_by_state = filter_by_state(filtered_by_country, state)
    filtered_by_city = filter_by_city(filtered_by_state, city)
  
    filtered_by_travel = filter_by_travel(profession, country, state, city)
  
    return filtered_by_city.or(filtered_by_travel)
  end
  
  # Helper method to filter by profession
  private_class_method def self.filter_by_profession(profession)
    profession.present? ? GeneralInfo.where(job_name: profession) : GeneralInfo.all
  end
  
  # Helper method to filter by country
  private_class_method def self.filter_by_country(filtered_users, country)
    country.present? ? filtered_users.where(country: country) : filtered_users
  end
  
  # Helper method to filter by state
  private_class_method def self.filter_by_state(filtered_users, state)
    state.present? ? filtered_users.where(state: state) : filtered_users
  end
  
  # Helper method to filter by city
  private_class_method def self.filter_by_city(filtered_users, city)
    city.present? ? filtered_users.where("LOWER(city) = ?", city.downcase) : filtered_users
  end
  
  # Helper method to filter by travel attributes
  private_class_method def self.filter_by_travel(profession, country, state, city)
    filtered_users1 = profession.present? ? GeneralInfo.where(job_name: profession) : GeneralInfo.all
    filtered_users1 = filter_by_travel_country(filtered_users1, country)
    filtered_users1 = filter_by_travel_state(filtered_users1, state)
    filtered_users1 = filter_by_travel_city(filtered_users1, city)
  
    filtered_users1 = filter_by_travel_dates(filtered_users1)
  
    filtered_users1
  end
  
  # Helper method to filter by travel country
  private_class_method def self.filter_by_travel_country(filtered_users1, country)
    country.present? ? filtered_users1.where(travel_country: country) : filtered_users1
  end
  
  # Helper method to filter by travel state
  private_class_method def self.filter_by_travel_state(filtered_users1, state)
    state.present? ? filtered_users1.where(travel_state: state) : filtered_users1
  end
  
  # Helper method to filter by travel city
  private_class_method def self.filter_by_travel_city(filtered_users1, city)
    city.present? ? filtered_users1.where(travel_city: city) : filtered_users1
  end
  
  # Helper method to filter by travel dates
  private_class_method def self.filter_by_travel_dates(filtered_users1)
    filtered_users1.where(travel_start: Date.today..30.days.from_now.to_date)
                    .or(filtered_users1.where(travel_end: Date.today..30.days.from_now.to_date))
                    .or(filtered_users1.where('travel_start < ?', Date.today)
                                        .where('travel_end > ?', Date.today))
  end  

end
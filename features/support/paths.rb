module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the search page$/
      '/search_profile/search'
    when /^the search results page$/
      '/search_profile/show/'
    when /^the home page$/
      '/'
    when /^the general info page$/
      '/general_info/new'
    when /^the profile page$/
      '/show_profile'
    when /^the edit page$/
      '/general_info/edit'
    when /^the sign up page$/
      '/login_info/new'
    when /^the login page$/
      '/login_info/login'
    when /^login$/
      '/login_info/login'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)

module NavigationHelpers
  def path_to(page_name)
    case page_name
      when /^the search page$/
        '/search_profile/search'

      when /^the search results page$/
        '/search_profile/show/'

      when /^the home page$/
        root_path

      when /^the landing page$/
        root_path

      when /^the general info page$/
        '/general_info/new'

      when /^the second signup page$/
        '/general_info/new2'

      when /^the profile page$/
        '/show_profile'

      when /^the edit page$/
        '/general_info/edit'

      when /^the sign up page$/
        '/login_info/new'

      when /^the login page$/
        '/login'

      when /^the login_info login page$/
        '/login_info/login'

      when /^the search engine page$/
        '/search_engine/search'

      when /^the DM page$/
        '/dm'

      when /^the gallery page$/
        '/galleries'

      when /^the edit gallery page$/
        '/galleries/edit'

      when /^the edit gallery page with id (\d+)$/
        '/galleries/' + $1 + '/edit'

      else
        send(page_name + "_path")
        # raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)

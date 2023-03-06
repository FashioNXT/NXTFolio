# a handy debugging step you can use in your scenarios to invoke 'pry' mid-scenario and poke around
When('I debug') do
    binding.pry
end

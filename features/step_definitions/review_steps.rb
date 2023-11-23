# features/step_definitions/reviews_steps.rb
When("I fill in the rating field with {int}") do |rating|
    page.execute_script("document.querySelector('input[name=\"review[rating]\"]').value = #{rating};")
  end
  

Then("I should be able to view the Rating") do
    rating_input_value = page.evaluate_script('document.querySelector("input[name=\'score\'][type=\'hidden\'][readonly]").value')
    expect(rating_input_value.to_i).to eq(5)
  end

Then("I should be able to view the updated Rating") do
    rating_input_value = page.evaluate_script('document.querySelector("input[name=\'score\'][type=\'hidden\'][readonly]").value')
    expect(rating_input_value.to_i).to eq(4)
  end

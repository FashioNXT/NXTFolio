class NewprofessionController < ApplicationController
  def new
    @newprofession = Newprofession.new
  end
end

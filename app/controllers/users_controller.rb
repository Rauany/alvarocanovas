class UsersController < ApplicationController

  def index
    @owner = User.find_by_name('owner')
    @agency = User.find_by_name('agency')
  end

end

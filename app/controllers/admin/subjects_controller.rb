class Admin::SubjectsController < Admin::ApplicationController
  def index
    @subjects = Subject.all
  end
end

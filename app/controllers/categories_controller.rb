class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def show
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:code])
    end
end

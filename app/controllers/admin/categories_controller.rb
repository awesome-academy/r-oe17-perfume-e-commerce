class Admin::CategoriesController < Admin::BaseController
  before_action :logged_in_user
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.ordered_by_name
                          .page(params[:page])
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t ".create_success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = t ".update_success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.products.present?
      flash[:warning] = t ".has_product"
      redirect_to admin_categories_url
    else
      @category.destroy
      if @category.destroyed?
        flash[:success] = t ".delete_success"
        redirect_to admin_categories_url
      else
        flash[:danger] = t ".delete_unsuccess"
      end
    end
  end

  private
  def category_params
    params.require(:category).permit(:category_name, :description)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      flash[:danger] = t ".set_category_invalid"
      redirect_to admin_root_url
    end
  end
end

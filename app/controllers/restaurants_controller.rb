class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :require_restaurant_owner, only: [:edit, :update, :destroy], unless: -> { current_user&.admin? }
  before_action :require_admin, only: [:index, :approve, :suspend]
  before_action :check_existing_restaurant, only: [:new, :create], unless: -> { current_user&.admin? }
  before_action :load_restaurant_owners, only: [:new], if: -> { current_user&.admin? }

  def index
    @restaurants = Restaurant.includes(:user).order(created_at: :desc)
    @pending_count = Restaurant.pending.count
    @approved_count = Restaurant.approved.count
    @suspended_count = Restaurant.suspended.count
  end

  def show
    authorize_restaurant_access
  end

  def new
    @restaurant = Restaurant.new
    @user = User.new if current_user.admin?
  end

  def create
    if current_user.admin?
      create_restaurant_as_admin
    else
      create_restaurant_as_owner
    end
  end

  def edit
    authorize_restaurant_access
  end

  def update
    authorize_restaurant_access
    
    # Admins can update status, owners cannot
    if current_user.admin?
      if @restaurant.update(restaurant_params)
        redirect_to restaurants_path, notice: "Restaurant updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Owners cannot change status
      owner_params = restaurant_params.except(:status)
      if @restaurant.update(owner_params)
        redirect_to @restaurant, notice: "Restaurant updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    authorize_restaurant_access
    @restaurant.destroy
    redirect_to restaurants_path, notice: "Restaurant deleted successfully."
  end

  # Admin actions
  def approve
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(status: "approved")
    redirect_to restaurants_path, notice: "Restaurant approved successfully."
  end

  def suspend
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(status: "suspended")
    redirect_to restaurants_path, notice: "Restaurant suspended successfully."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :owner_name, :email, :phone, :address, :plan, :status, :user_id)
  end

  def user_params
    return {} unless params[:user].present?
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end

  def authorize_restaurant_access
    unless current_user.admin? || (@restaurant.user == current_user)
      redirect_to root_path, alert: "You don't have permission to access this restaurant."
    end
  end

  def check_existing_restaurant
    if current_user.restaurant_owner? && current_user.restaurant.present?
      redirect_to current_user.restaurant, alert: "You already have a restaurant registered."
    end
  end

  def load_restaurant_owners
    @restaurant_owners = User.restaurant_owners.where.missing(:restaurant).order(:email_address)
  end

  def create_restaurant_as_admin
    ActiveRecord::Base.transaction do
      # Determine which user to use
      user = if params[:restaurant][:user_id].present?
        # Use existing user
        User.find(params[:restaurant][:user_id])
      elsif params[:user].present? && params[:user][:email_address].present?
        # Create new user
        user = User.new(user_params)
        user.role = "restaurant_owner"
        unless user.save
          @restaurant = Restaurant.new(restaurant_params.except(:user_id))
          @user = user
          @restaurant_owners = User.restaurant_owners.where.missing(:restaurant).order(:email_address)
          render :new, status: :unprocessable_entity
          return
        end
        user
      else
        @restaurant = Restaurant.new(restaurant_params)
        @user = User.new
        @restaurant_owners = User.restaurant_owners.where.missing(:restaurant).order(:email_address)
        @restaurant.errors.add(:base, "Please either select an existing user or create a new user account.")
        render :new, status: :unprocessable_entity
        return
      end

      # Check if user already has a restaurant
      if user.restaurant.present?
        @restaurant = Restaurant.new(restaurant_params.except(:user_id))
        @user = User.new
        @restaurant_owners = User.restaurant_owners.where.missing(:restaurant).order(:email_address)
        @restaurant.errors.add(:base, "This user already has a restaurant registered.")
        render :new, status: :unprocessable_entity
        return
      end

      # Create restaurant
      @restaurant = user.build_restaurant(restaurant_params.except(:user_id))
      @restaurant.status = params[:restaurant][:status] || "approved" # Admins can set status directly

      if @restaurant.save
        redirect_to restaurants_path, notice: "Restaurant created successfully!"
      else
        @user = User.new
        @restaurant_owners = User.restaurant_owners.where.missing(:restaurant).order(:email_address)
        render :new, status: :unprocessable_entity
      end
    end
  end

  def create_restaurant_as_owner
    @restaurant = current_user.build_restaurant(restaurant_params.except(:user_id))
    @restaurant.status = "pending" # All new restaurants start as pending

    if @restaurant.save
      redirect_to dashboard_path, notice: "Restaurant registered successfully! It will be reviewed and approved by an admin."
    else
      render :new, status: :unprocessable_entity
    end
  end
end


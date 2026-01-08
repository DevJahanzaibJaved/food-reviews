class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    
    if user
      # Use deliver_now in development so letter_opener works immediately
      # In production, you can switch to deliver_later for background processing
      begin
        PasswordsMailer.reset(user).deliver_now
        Rails.logger.info "Password reset email sent to: #{user.email_address}"
      rescue => e
        Rails.logger.error "Failed to send password reset email: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        redirect_to new_password_path, alert: "Failed to send email. Please try again."
        return
      end
    else
      Rails.logger.warn "Password reset requested for non-existent email: #{params[:email_address]}"
    end

    # Always show success message to prevent email enumeration
    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Password has been reset."
    else
      # Show all validation errors
      error_messages = @user.errors.full_messages
      if error_messages.any?
        redirect_to edit_password_path(params[:token]), alert: error_messages.join(". ")
      else
        redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
      end
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
end

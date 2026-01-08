class PagesController < ApplicationController
  allow_unauthenticated_access only: [:home]

  def home
  end

  def dashboard
    # Dashboard logic will be added in later phases
    # For now, just show a basic dashboard
  end
end


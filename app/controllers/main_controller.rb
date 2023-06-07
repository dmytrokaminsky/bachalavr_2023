class MainController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :main, :index?
    @themes = Theme.order(:title).where('questions_count > ?', 0 )
  end

  def audit
    authorize :main, :audit?
    @q = Audit.ransack(params[:q])
    @audits = @q.result(distinct: true)

    @pagy, @audits = pagy(@audits.includes(:user).order(created_at: :desc))
  end
end

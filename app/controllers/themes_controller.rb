class ThemesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_theme,          only:   %i[show edit update destroy check]

  after_action :verify_authorized

  def index
    authorize Theme
    @q = Theme.ransack(params[:q])
    @themes = @q.result(distinct: true)

    @pagy, @themes = pagy(@themes.order(title: :desc))
  end

  def show
    authorize @theme
  end

  def new
    @theme = Theme.new
    authorize @theme
  end

  def create
    @theme = Theme.new(theme_params)
    authorize @theme

    @theme.audit_comment = t('audit.comments.theme_name', theme: @theme.title)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to themes_url, notice: t('flash.was_created', item: Theme.model_name.human) }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def edit
    authorize @theme
  end

  def update
    authorize @theme
    respond_to do |format|
      if @theme.update(theme_params)
        format.html { redirect_to themes_url, notice: t('flash.was_updated', item: Theme.model_name.human) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @theme

    @theme.destroy
    respond_to do |format|
      format.html { redirect_to themes_url, notice: t('flash.was_destroyed', item: Theme.model_name.human)  }
    end
  end



  private
    def set_theme
      @theme = Theme.find(params[:id])
    end


    def theme_params
      params.require(:theme).permit(:title)
    end
end

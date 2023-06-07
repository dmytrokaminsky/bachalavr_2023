class RoundsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_round, only: %i[show destroy result]
  after_action :verify_authorized

  def index
    authorize Round

    @rounds = Round.all
  end

  def show
    authorize @round

    @all_questions = Question.where(id: @round.questions_collection - @round.question_ids)
    @pagy, @questions = pagy(@all_questions, items: 1)
  end

  def result
    authorize @round
    @round.make_finish unless @round.finished
    @results = @round.results.includes(:answer, question: [:author])
  end

  def new
    @round = Round.new(theme_id: params[:theme_id])
    @round.user = current_user

    authorize @round

    @round.audit_comment = t('audit.comments.on_theme', theme: @round.theme.title)

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_round
      @round = Round.find(params[:id])
    end
end

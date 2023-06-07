class RoundPolicy < ApplicationPolicy
  def index?
    @user && (@user.admin? || @user.moderator?)
  end

  def show?
    (record.user_id == @user.id) && !record.finished
  end

  def result?
    record.user_id == @user.id || (@user.admin? || @user.moderator?)
  end

  def new?
    record.theme.questions_count > 0
  end
end

class QuestionPolicy < ApplicationPolicy
  def index?
    @user && (@user.admin? || @user.moderator?)
  end

  def show?
    @user && (@user.admin? || @user.moderator?)
  end

  def check?
    @user
  end

  def new?
    @user && (@user.admin? || @user.moderator?)
  end

  def create?
    @user.admin? || @user.moderator?
  end

  def edit?
    @user && (@user.admin? || @user.moderator?)
  end

  def update?
    @user.admin? || @user.moderator?
  end


  def destroy?
    @user.admin? || @user.moderator?
  end

end

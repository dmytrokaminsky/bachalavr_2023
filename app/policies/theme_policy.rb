class ThemePolicy < ApplicationPolicy
  def index?
    @user && (@user.admin? || @user.moderator?)
  end

  def show?
    @user
  end

  def new?
    @user && (@user.admin? || @user.moderator?)
  end

  def create?
    @user && (@user.admin? || @user.moderator?)
  end

  def edit?
    @user && (@user.admin? || @user.moderator?)
  end

  def update?
    @user && (@user.admin? || @user.moderator?)
  end

  def destroy?
    @user && (@user.admin? || @user.moderator?)
  end

end

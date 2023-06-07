class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    @user && @user.admin?
  end

  def update?
    @user && @user.admin?
  end

  def get_more_info?
    @user && @user.admin?
  end
end

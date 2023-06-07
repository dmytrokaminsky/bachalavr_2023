class MainPolicy < Struct.new(:user, :main)
  def index?
    true
  end

  def audit?
    user && user.admin?
  end
end

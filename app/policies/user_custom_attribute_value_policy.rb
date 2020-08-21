class UserCustomAttributeValuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && !user.admin?
  end
end

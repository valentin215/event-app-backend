class EventCustomAttributeValuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.includes(:event_registration_form).where(event_registration_forms: { user_id: user.id })
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

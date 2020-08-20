class EventRegistrationFormPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def new?
    true
  end

  def show?
    if user.admin?
      true
    else
      user.id == registration_form.user_id
    end
  end

  def create?
    user.present?
  end

  private

  def registration_form
    record
  end
end
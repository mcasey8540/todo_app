class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new

    # Define User abilities
    if user.is? :non_admin
      can :manage, List, :user_id => user.id
    end
  end

end

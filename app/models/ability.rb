class Ability
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:
    #
    #
    admin ||= Admin.new # guest user (not logged in)


    # スーパー権限を持つユーザができること
    # 1
    if admin[:role_id] == 1
      can :manage, Admin
      can :manage, Project
      can :manage, Task
      can :manage, Event
      can :manage, Company
      can :manage, Super
    end

    # 開発権限を持つユーザができること
    # 2
    if admin[:role_id] == 2
      can :read, Admin
      can :manage, Project
      can :manage, Task
      can :manage, Event
      can :manage, Company
    end

    # オペレーション権限を持つユーザーができること
    # 3
    if admin[:role_id] == 3
      can :read, Project
      can :read, Task
      can :read, Event
    end

    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

class Ability
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:
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
      cannot :manage, Admin
      can    :manage, Project
      can    :manage, Task
      can    :manage, Event
      can    :manage, Company
      can    :manage, Super
    end

    # オペレーション権限を持つユーザーができること
    # 3
    if admin[:role_id] == 3
      can :read, Project
      can :read, Task
      can :manage, Event
      can :manage, Super
    end

    if admin[:role_id] == nil
      can    :manage, Super
      cannot :manage, Admin
      cannot :manage, Task
      cannot :manage, Event
      cannot :manage, Company
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

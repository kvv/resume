authorization do

  # Не зарегистрированный пользователь
  role :guest do
    has_permission_on :authorization_rules, :to => :manage
    has_permission_on :authorization_usages, :to => :manage
  end

  # Зарегистрированные пользователи
  role :user do
    includes :guest
    has_permission_on [:dashboard_accounts],    :to => [:show, :edit, :update]
  end

  # Рекламодатели
  role :advertiser do
    includes :user
  end

  # Партнеры
  role :partner do
    includes :user
    includes :advertiser
  end

  # Администратор
  role :admin do
    includes :user
    includes :advertiser
    includes :partner
    has_permission_on [:admin_users],             :to => [:manage]
  end

end

privileges do
  privilege :manage, :includes => [:index, :create, :read, :update, :delete]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  privilege :move, :includes => [:move_up, :move_down]
end


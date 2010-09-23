=begin rdoc
Пользователи
=end
class User < ActiveRecord::Base

  attr_accessible :login, :email, :password, :password_confirmation, :city_name, :active, :role_ids
  acts_as_authentic do |c|
    c.login_field = 'email'
  end

  # Associations
  has_and_belongs_to_many :roles
  has_many :magazines
  has_many :products
  has_many :tickets
  has_many :replies

  def categories
    categories = []
    self.products.each {|x| categories << x.category unless categories.include?(x.category);}
    categories
  end

  # Validations
  validates_presence_of :email, :city_name

  # callback
  after_create      :add_default_role


  # named_scope
  default_scope :order => "id"
  named_scope :active, :conditions => {:active => true}
  named_scope :inactive, :conditions => {:active => false}

  def add_default_role
    add_role(:user)
  end

  def signup!(params)
    self.login                 = params[:user][:login]
    self.email                 = params[:user][:email]
    self.password              = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save_without_session_maintenance
  end

  def activate!
    self.active = true
    save
  end


  # deliver
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  # roles
  def has_role?(role)
    self.roles.count(:conditions => ["name = ?", role.to_s]) > 0
  end

  # user.add_role("admin")
  def add_role(role)
    return if self.has_role?(role)
    self.roles << Role.find_by_name(role.to_s)
  end

  def remove_role(role)
    return false unless self.has_role?(role)
    role = Role.find_by_name(role)
    self.roles.delete(role)
  end

  def admin?
    @_roles ||= roles
    self.has_role?("admin")
  end

  # permissions
  def role_symbols
    (roles || []).map{ |x|  x.name.underscore.to_sym }
  end

  def self.not_admin
    self.all.select {|x| !x.admin? }
  end

  def self.admins
    self.all.select {|x| x.admin? }
  end

end


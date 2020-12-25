class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_one_admin_remains

  def self.create_if_empty(name, password)
    return User.create(name: name, password: password) if User.count.zero?
    User.find_by(name: name)
  end

  private

    def ensure_one_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end

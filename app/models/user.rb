class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_one_admin_remains

  private

    def ensure_one_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end

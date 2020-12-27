class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true, length: {minimum: 10, message: "%{value} is least 10 characters"}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s), message: "%{value} is not available language" } 

  def self.latest
    Product.order(:updated_at).last
  end

  private

    def ensure_not_referenced_by_any_line_items
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end

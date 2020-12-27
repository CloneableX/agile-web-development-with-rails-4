require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be postive" do
    product = Product.new(title: 'My Book Title',
                         description: 'yyy',
                         image_url: 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'],
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'My Book Title',
               description: 'yyy',
               price: 1,
               image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG
             FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} should be valid"
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} should be invalid"
    end
  end

  test "product is invalid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                         description: 'yyy',
                         price: 1,
                         image_url: 'ruby.png')
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test "product title length is least 10 characters" do
    product = Product.new(title: 'aaaaaaaaa',
                         description: 'yyy',
                         price: 1,
                         image_url: 'zzz.jpg')
    assert product.invalid?
    assert_equal ["#{product.title} is least 10 characters"], product.errors[:title]
  end

  test "locale should be included in available language" do
    product = Product.new(title: 'aaa', description: 'yyy', price: 1, image_url: 'zzz.jpb', locale: 'Invalid Locale')

    assert product.invalid?
    assert_equal ["Invalid Locale is not available language"], product.errors[:locale]
  end
end

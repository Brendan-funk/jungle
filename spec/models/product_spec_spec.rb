require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'TEST')
    end

    it 'should save a valid product' do
      @testProduct = @category.products.create!(
        name:'test',
        price_cents: 99,
        quantity: 4
      )
      expect(@testProduct).to be_valid
    end

    it 'should not save when name is invalid' do  
      @testProduct = Product.new(
        name: nil, 
        price: 4200, 
        quantity: 4, 
        category: @category
        )   
      @testProduct.save
      expect(@testProduct.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save when price is invalid' do  
      @testProduct = Product.new(
        name: 'test', 
        price: nil, 
        quantity: 4, 
        category: @category
        )   
      @testProduct.save
      expect(@testProduct.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save when quantity is invalid' do  
      @testProduct = Product.new(
        name: 'test', 
        price: 99, 
        quantity: nil, 
        category: @category
        )   
      @testProduct.save
      expect(@testProduct.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save when category is invalid' do  
      @testProduct = Product.new(
        name: 'test', 
        price: 99, 
        quantity: 4, 
        category: nil
        )   
      @testProduct.save
      expect(@testProduct.errors.full_messages).to include("Category can't be blank")
    end
  end
end

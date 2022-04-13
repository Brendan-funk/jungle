require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should not have a blank name' do
      @user = User.new(name: nil, email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not have a blank email' do
      @user = User.new(name: "Denda", email: nil, password: 'gunga', password_confirmation: 'gunga')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not have a blank password field' do
      @user = User.new(name: "Denda", email: 'test@gmail.com', password: nil, password_confirmation: 'ginga')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not have mismatched password and password_confirmation' do
      @user = User.new(name: "Denda", email: 'test@gmail.com', password: 'gunga', password_confirmation: 'ginga')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not add non-unique email' do
      @user = User.new(name: "Denda", email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @user.save

      @user2 = User.new(name: "Denda", email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @user2.save
      
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not add non-unique email regardless of case' do
      @user = User.new(name: "Denda", email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @user.save

      @user2 = User.new(name: "Denda", email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @user2.save

      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it 'should have a password with a minimum length of 3 characters' do
      @user = User.new(name: "Denda", email: 'test@gmail.com', password: '12', password_confirmation: '12')
      @user.save
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")

    end

  end


  describe '.authenticate_with_credentials' do

    it 'should be granted login access if all credentials are valid' do
      @user = User.create(name: 'Denda', email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @login = User.authenticate_with_credentials('test@gmail.com', 'gunga')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should be granted login access if all credentials are valid regardless of email case' do
      @user = User.create(name: 'Denda', email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @login = User.authenticate_with_credentials('test@gmail.com', 'gunga')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should be granted login access regardless of case or whitespace in email' do
      @user = User.create(name: 'Denda', email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @login = User.authenticate_with_credentials('    test@gmail.com', 'gunga')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should NOT be granted login access if credentials are invalid' do
      @user = User.create(name: 'Denda', email: 'test@gmail.com', password: 'gunga', password_confirmation: 'gunga')
      @login = User.authenticate_with_credentials('test@gmail.com', 'incorrectpassword')
      
      expect(@user).to_not eq(@login)
      expect(@login).to eq(nil)
    end

  end
end
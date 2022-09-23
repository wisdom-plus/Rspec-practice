# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'hasa valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is valid with a first name, last name, email, and password' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email address' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    create(:user, email: 'test@example.com')
    user = build(:user, email: 'test@example.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'return a user full name as a string' do
    user = build(:user, first_name: 'John', last_name: 'Doe')
    expect(user.name).to eq 'John Doe'
  end
end

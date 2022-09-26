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

  it { is_expected.to validate_presence_of(:first_name)}
  it { is_expected.to validate_presence_of(:last_name)}
  it { is_expected.to validate_presence_of(:email)}
  it {is_expected.to validate_uniqueness_of(:email).case_insensitive}

  it 'return a user full name as a string' do
    user = build(:user, first_name: 'John', last_name: 'Doe')
    expect(user.name).to eq 'John Doe'
  end

  it "performs geocoding", vcr: true do
    user = FactoryBot.create(:user, last_sign_in_ip: "161.185.207.20")
    expect {
      user.geocode
    }.to change(user, :location).
    from(nil).
    to("New York City, New York, US")
  end
end

require 'spec_helper'


describe User do
  it "requires an email" do
    u = User.new(firstname: 'Tony',
                 lastname:  'Danza',
                 password:  'topsecret',
                 password_confirmation:  'topsecret')
    u.save
    expect(u).to_not be_valid

    u.email = Faker::Internet.email
    u.save
    expect(u).to be_valid
  end
end

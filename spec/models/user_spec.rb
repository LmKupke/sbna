require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when("Bran Stark", "Hodor HoldtheDoor") }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when("Bran Stark", "Hodor HoldtheDoor") }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when("warthogbran@got.com", "hodor@gmail.com") }
  it { should_not have_valid(:email).when(nil, '', 'warthog', 'warthog@com', 'wartha.com') }

  it { should have_valid(:phone_number).when("1234567890", "4043089999" ) }
  it { should_not have_valid(:phone_number).when("12345678901", nil ) }

  it { should have_valid(:zipcode).when("02115", "02123" ) }
  it { should_not have_valid(:zipcode).when("111111", nil) }

  it { should have_valid(:street).when("11 Durham Street", "9 Saint Botolph" ) }
  it { should_not have_valid(:street).when("Durham Street", nil ) }

  it { should have_valid(:city).when("Boston", "Atlanta" ) }
  it { should_not have_valid(:city).when("", nil ) }

  it { should have_valid(:state).when("MA", "GA" ) }
  it { should_not have_valid(:state).when("ZA","Georgia", nil ) }

  it { should have_valid(:other_address).when("Apt. 2", "Unit 3", nil ) }


  describe '.fullname' do
    it 'returns the name of the user' do
      user = create(:user)
      name = user.fullname
      expect(name).to eq("Jon Snow")
    end
  end


  describe '.email' do
    it 'returns the email of the user' do
      user = create(:user, email: "valarmorghulis@gmail.com")
  	  result = user.email
  	  expect(result).to eq("valarmorghulis@gmail.com")
    end
  end

  describe '.password' do
    it 'returns the password of the user' do
      user = create(:user, password: "manyfacedgod", password_confirmation: "manyfacedgod")
  	  result = user.password
  	  expect(result).to eq("manyfacedgod")
    end
  end

  describe '.role' do
    context 'user is a member' do
      it 'returns member' do
        user = create(:user)
    	  result = user.role
    	  expect(result).to eq("member")
      end
    end

    context 'user is a admin' do
      it 'returns admin' do
        user = create(:user, role:"admin")
    	  result = user.role
    	  expect(result).to eq("admin")
      end
    end
  end

  describe "#admin?" do
    context 'when user is a member' do
      it 'returns false' do
        user = create(:user)
        expect(user.admin?).to eq(false)
      end
    end

    context "when user is an admin" do
      it 'returns true' do
        user = create(:user, role: "admin", admin: true )
        expect(user.admin?).to eq(true)
      end
    end
  end
end

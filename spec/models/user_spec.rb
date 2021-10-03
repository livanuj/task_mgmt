require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(email: "abc@example.com",
                        password: "test@123"
                        ) 
  }

  describe "validations" do
    it "valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "ensure the presence of password" do
      subject.password = nil

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /can't be blank/)
    end

    it "ensures the presence of email" do
      subject.email = nil

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /can't be blank/)
    end

    it "ensures the valid email address" do
      subject.email = 'invalidemail@123'

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /is not a valid email address/)
    end
  end

  describe "Associations" do
    it "should have many tasks" do
      t = User.reflect_on_association(:tasks)
      expect(t.macro).to eq(:has_many)
    end
  end
end

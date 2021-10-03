require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:user) { create(:user) }
  subject {
    described_class.new(description: "Lorem ipsum",
                        start_date: Date.today,
                        end_date: Date.today + 1.week,
                        user_id: user.id
                        ) 
  }

  describe 'validations' do
    it "valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "ensure the presence of description" do
      subject.description = nil

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /can't be blank/)
    end

    it "ensure the presence of description" do
      subject.start_date = nil

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /can't be blank/)
    end

    it "ensure the presence of description" do
      subject.end_date = nil

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /can't be blank/)
    end

    it "ensures Start is before the End" do
      subject.end_date = Date.today - 1.week

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /End date cannot be before start_date/)
    end

    it "ensures End is after the Start" do
      subject.start_date = Date.today + 2.week

      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, /End date cannot be before start_date/)
    end
  end

  describe "Associations" do
    it "should belongs to user" do
      t = Task.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end

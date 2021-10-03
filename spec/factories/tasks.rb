FactoryBot.define do
  factory :task do
    start_date { Date.today }
    end_date { Date.today + 1.week }
    description { "Lorem ipsum" }
  end
end

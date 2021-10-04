require 'rails_helper'

RSpec.describe "Tasks", type: :feature do
  let(:user) { create(:user) }

  before :each do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe "GET index" do
    before do
      create(:task, user: user)
      create(:task, user: user)
      create(:task, user: user)
    end

    it 'signs user in' do
      visit '/tasks'
      
      expect(page).to have_text("Task List")
      expect(page).to have_xpath(".//tr", :count => 4)
    end
  end

  describe "New page, POST Create" do
    let(:description) { "test description" }
    let(:start_date) { "2021-10-1" }
    let(:end_date) { "2021-10-10" }

    it "creates new task" do
      visit '/tasks/new'
      fill_in 'Start Date', with: start_date
      fill_in 'End date', with: end_date
      fill_in 'Description', with: description
      expect{ click_button 'Create Task' }.to change(Task, :count). by(1)

      expect(current_path).to eq(task_path(Task.last))
      expect(page).to have_text("Task Created Succesfully")
      expect(page).to have_text("test description")
    end
  end

  describe "Edit page, PUT Update" do
    let(:task) { create(:task, user: user) }
    let(:description) { "updated description" }

    it "updates existing task" do
      visit edit_task_url(task)
      fill_in 'Description', with: description
      expect{ click_button 'Update Task' }.to change(Task, :count). by(0)

      expect(current_path).to eq(task_path(task))
      expect(page).to have_text("Task Updated Succesfully")

      expect(page).to have_text("updated description")
    end
  end

  describe "Show and DELETE Destroy" do
    let(:task) { create(:task, user: user) }

    it "deletes existing task" do
      visit task_url(task)
      expect(page).to have_text("Show")   

      expect { click_link 'Destroy' }.to change(Task, :count). by(-1)
      expect(current_path).to eq(tasks_path)
      expect(page).to have_text("Task Deleted Succesfully")
    end
  end
end

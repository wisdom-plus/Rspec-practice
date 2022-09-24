require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user,name: "RSpec tutorial") }
  let!(:task) { project.tasks.create!(name: "Finish RSpec tutorial") }

  scenario 'user creates a new task', js: true do
    sign_in(user)
    visit root_path

    click_link 'RSpec tutorial'
    check "Finish RSpec tutorial"

    expect(page).to have_css "label#task_#{task.id}.completed"
    expect(task.reload).to be_completed

    uncheck "Finish RSpec tutorial"

    expect(page).not_to have_css "label#task_#{task.id}.completed"
    expect(task.reload).not_to be_completed
  end

  scenario "user toggles a task", js: true do
    sign_in user
    go_to_project "RSpec tutorial"

    complete_task "Finish RSpec tutorial"
    expect_complete_task "Finish RSpec tutorial"

    undo_complete_task "Finish RSpec tutorial"
    expect_incomplete_task "Finish RSpec tutorial"
  end

  def go_to_project(name)
    visit root_path
    click_link name
  end

  def complete_task(name)
    check name
  end

  def undo_complete_task(name)
    uncheck name
  end

  def expect_complete_task(name)
    expect(page).to have_css "label.completed", text: name
    expect(task.reload).to be_completed
  end

  def expecct_incomplete_task(name)
    expect(page).to_not have_css "label.completed", text: name
    expect(task.reload).to_not be_completed
  end
end

require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  scenario 'user creates a new task', js: true do
    user = create(:user)
    project = create(:project, name: "RSpec tutorial", owner: user)
    task = project.tasks.create(name: "Finish RSpec tutorial")

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
end

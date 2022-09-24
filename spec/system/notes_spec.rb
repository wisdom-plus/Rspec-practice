require 'rails_helper'

RSpec.describe "Notes", type: :system do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user, name: "RSpec tutorial") }

  scenario "user uploads an attachment", js: true do
    sign_in user
    visit project_path(project)
    click_link "Add Note"
    fill_in "Message", with: "My book cover"
    attach_file "Attachment", "#{Rails.root}/spec/files/coffee_test.jpg"
    click_button "Create Note"

    aggregate_failures do
      expect(page).to have_content "Note was successfully created"
      expect(page).to have_content "My book cover"
      expect(page).to have_content "coffee_test.jpg (image/jpeg"
    end
  end
end

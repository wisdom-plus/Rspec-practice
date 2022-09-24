# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id)}

  it 'allows two users to share a project name' do
    create(:project, name: 'Test Project')

    other_project = build(:project, name: 'Test Project')

    expect(other_project).to be_valid
  end

  describe 'late status' do
    it 'is late when the due date is past today' do
      project = create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it 'is on time when the due date is today' do
      project = create(:project, :due_today)
      expect(project).not_to be_late
    end

    it 'is on time when the due date is in the future' do
      project = create(:project, :due_tomorrow)
      expect(project).not_to be_late
    end
  end

  it 'canhave many notes' do
    project = create(:project, :with_notes)
    expect(project.notes.length).to eq 5
  end
end

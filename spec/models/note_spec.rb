# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = create(:user)

    @project = create(:project, owner: @user)
  end

  it 'is valid with a user, project, and message' do
    note = described_class.new(
      message: 'This is a sample note.',
      user: @user,
      project: @project
    )
    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = described_class.new(
      message: nil
    )
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe 'search message for a term' do
    before do
      @note1 = create(:note, project: @project, message: 'This is the first note.')
      @note2 = create(:note, project: @project, message: 'This is the second note.')
      @note3 = create(:note, project: @project, message: 'First, preheat the oven.')
    end

    context 'when a match is found' do
      it 'returns notes that match the search term' do
        expect(described_class.search('first')).to include(@note1, @note3)
        expect(described_class.search('first')).not_to include(@note2)
      end
    end

    context 'when no match is found' do
      it 'does not return notes that do not match the search term' do
        expect(described_class.search('message')).to be_empty
      end
    end
  end
end

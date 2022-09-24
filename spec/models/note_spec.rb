# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project)}

  it 'is valid with a user, project, and message' do
    note = build(:note)
    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  it 'delegates name to the user who created it' do
    user = instance_double("user", name: "Fake User")
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq "Fake User"
  end

  describe 'search message for a term' do
    let!(:note1){create(:note, project: project, message: 'This is the first note.')}
    let!(:note2){create(:note, project: project, message: 'This is the second note.')}
    let!(:note3){create(:note, project: project, message: 'First, preheat the oven.')}


    context 'when a match is found' do
      it 'returns notes that match the search term' do
        expect(described_class.search('first')).to include(note1, note3)
        expect(described_class.search('first')).not_to include(note2)
      end
    end

    context 'when no match is found' do
      it 'does not return notes that do not match the search term' do
        expect(described_class.search('message')).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end
end

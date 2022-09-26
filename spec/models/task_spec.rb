require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { create(:project) }

  it "is valid with a porject and name" do
    task = Task.new(project: project, name: "Test task")

    expect(task).to be_valid
  end

  it "is invalid without a project" do
    task = Task.new(project: nil)
    task.valid?
    expect(task.errors[:project]).to include("must exist")
  end

  it "is invalid without a name" do
    task = Task.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end

  it 'sends a welcom email on account creation' do
    allow(UserMailer).to receive_message_chain(:welcome_email, :deliver_later)
    user = create(:user)
    expect(UserMailer).to have_received(:welcome_email).with(user)
  end
end

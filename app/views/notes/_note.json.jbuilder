# frozen_string_literal: true

json.extract! note, :id, :message, :project_id, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)

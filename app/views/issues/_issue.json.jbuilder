json.extract! issue, :subject, :description, :id, :tipus, :severity, :priority, :issue, :status, :assign_to, :created_at, :updated_at
json.url issue_url(issue, format: :json)

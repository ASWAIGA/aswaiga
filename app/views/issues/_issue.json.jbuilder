json.extract! issue, :description, :id, :tipus, :severity, :priority, :issue, :status, :assign_to, :created_at, :updated_at, :due_date, :reason_due_date, :block_status, :reason_block
json.url issue_url(issue, format: :json)

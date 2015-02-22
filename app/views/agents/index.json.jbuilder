json.array!(@agents) do |agent|
  json.extract! agent, :id, :name
  json.url agent_url(agent, format: :json)
end

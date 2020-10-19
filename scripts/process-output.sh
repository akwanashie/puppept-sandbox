
function count-sucessful-notices {
  MATCHES=$(docker exec -it puppetagent bash -c "echo ']' >> /agent-data/output.json && cat /agent-data/output.json | jq -c 'map(select(.message | contains(\"executed successfully\"))) | length'")
  # docker exec -it puppetagent rm /agent-data/output.json
  echo $MATCHES
}
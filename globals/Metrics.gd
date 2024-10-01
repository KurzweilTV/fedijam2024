extends Node

@onready var http_request: HTTPRequest = HTTPRequest.new()

const LOKI_URL = "http://localhost:3100/loki/api/v1/push"

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

func push_metric(metric_name: String, value: int) -> void:
	var timestamp = Time.get_unix_time_from_system() * 1000000000
	print(timestamp) # Nanosecond precision
	var labels = {
		"job": "godot_metrics",
		"game": "cloud_game",
		"metric": metric_name,
	}
	var values = [[str(timestamp), "Action: %s" % [metric_name]]]
		
	var payload = {
		"streams": [
			{
				"stream": labels, 
				"values": values
			}
		]
	}

	# Send the request to Loki
	var headers = ["Content-Type: application/json"]
	print(str(payload))
	http_request.request(LOKI_URL, headers, HTTPClient.METHOD_POST, str(payload))

# fires when the HTTP request signals it's done
func _on_request_completed(result, response_code, headers, body):
	print("Response code:", response_code)
	if response_code == 204:
		print("Log pushed to Loki successfully.")
	else:
		print("Failed to push log. Response:", body)

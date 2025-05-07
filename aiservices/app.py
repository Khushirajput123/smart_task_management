from flask import Flask, request, jsonify
from flask_cors import CORS
import os

from agents.scheduler import get_schedule

app = Flask(__name__)
CORS(app)
# if not model:
#     raise RuntimeError("Model not initialized. Ensure GOOGLE_API_KEY is set in the environment.")
# schedule = get_schedule(model)
@app.route('/schedule', methods=['POST'])
def generate_schedule():
    data = request.get_json()

    description = data.get("description", "")
    deadline = data.get("deadline", "")

    if not description:
        return jsonify({"error": "Task description is required"}), 400

    schedule = get_schedule(description, deadline)

    return jsonify({
        "description": description,
        "deadline": deadline,
        "suggested_schedule": schedule
    })

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=True)

from flask import Blueprint, request, jsonify
from agents.scheduler import TaskScheduler

advisory_bp = Blueprint('advisory', __name__)
scheduler = TaskScheduler()

@advisory_bp.route('/schedule', methods=['POST'])
def get_schedule():
    data = request.get_json(force=True)
    description = data.get('description')
    deadline = data.get('deadline', 'not provided')

    if not description:
        return jsonify({"error": "'description' field is required."}), 400

    try:
        schedule_advice = scheduler.suggest_schedule(description, deadline)
        return jsonify({"schedule": schedule_advice})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

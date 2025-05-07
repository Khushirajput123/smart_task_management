from core.config import get_gemini_model

class TaskScheduler:
    """AI agent to suggest task scheduling based on description and deadline."""
    def __init__(self):
        self.model = get_gemini_model()

    def suggest_schedule(self, description: str, deadline: str) -> str:
        prompt = f"""
You are a smart scheduling assistant for a task manager.

Task Description: "{description}"
Deadline: "{deadline}"

Suggest an optimal time-blocked plan or part of the day to complete this task.
Respond in concise bullet points.
"""
        response = self.model.generate_content(prompt)
        return response.text.strip()

if __name__ == "__main__":
    # Quick test
    sched = TaskScheduler()
    advice = sched.suggest_schedule(
        "Write a report on quarterly sales trends",
        "2025-04-20"
    )
    print("Schedule Advice:\n", advice)

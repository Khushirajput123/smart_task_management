import os
from dotenv import load_dotenv
import google.generativeai as genai

# Load environment variables
load_dotenv()

# Retrieve and validate Gemini API key
GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY")
if not GOOGLE_API_KEY:
    raise RuntimeError("Missing GOOGLE_API_KEY in environment variables.")

# Configure the Gemini client
genai.configure(api_key=GOOGLE_API_KEY)

def get_gemini_model():
    """
    Returns a configured Gemini generative model instance.
    """
    return genai.GenerativeModel("gemini-pro")

# Make port 8000 available
EXPOSE 8000

# Command to run the application
CMD ["uv", "run", "chainlit", "run", "chatbot.py", "--host", "0.0.0.0", "--port", "8000", "-w"] 
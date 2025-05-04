# Make port 7860 available
EXPOSE 7860

# Command to run the application
CMD ["uv", "run", "chainlit", "run", "chatbot.py", "--host", "0.0.0.0", "--port", "7860", "-w"] 
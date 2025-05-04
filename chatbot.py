import chainlit as cl
from main import ChefAgent
from agents import Runner
import os
import asyncio

@cl.on_chat_start
async def start():
    cl.user_session.set("history", [])
    await cl.Message("Welcome to ChefAI! 👨‍🍳 I'm here to help you cook delicious meals. What dish would you like to make today?").send()


@cl.on_message
async def main(message: cl.Message):
    history = cl.user_session.get("history")
    user_query = message.content
    history.append({"role": "user", "content": user_query})


    msg = cl.Message(content="ChefAI is thinking👨‍🍳 ")
    await msg.send()

   
    agent = await ChefAgent()

    
    response =  Runner.run_streamed(
        starting_agent=agent,
        input=history,
    )

    
    async for event in response.stream_events():
        if event.type == "raw_response_event" and hasattr(event.data, 'delta'):
            token = event.data.delta

            if token == {} or not token:
             continue   
            

            if msg.content == "ChefAI is thinking👨‍🍳 ":
                msg.content = ""


            await msg.stream_token(token)

    
    if msg.content == "ChefAI is thinking👨‍🍳 ":
        msg.content = "Sorry, I couldn't process that. Could you please clarify?"

    

    history.append({"role": "assistant", "content": msg.content})

   
    cl.user_session.set("history", history)

#file reader mode
 

              

 
# Bloom & Co. AI Phone Receptionist

A voice agent with a real phone number, built on [Vapi](https://vapi.ai). "Maya" answers calls for Bloom & Co. Hair Studio, a made-up salon in Orlando. She:

- answers questions about hours, location, services, prices, stylists and policies
- takes appointment requests (service, stylist, day and time, name, phone number)
- takes messages for stylists or the manager
- ends the call politely when the caller is finished

| File | What it is |
|---|---|
| `system-prompt.md` | Maya's instructions and the salon's facts |
| `assistant.json` | Vapi settings: greeting, AI model, voice, speech-to-text, end-of-call behavior |
| `create-agent.sh` | Optional script that creates the agent and phone number through the Vapi API |
| `test-calls.md` | Test calls to make and a checklist for the submission |

## Setup in the Vapi dashboard (about 10 minutes, no code)

1. **Make an account.** Sign up at https://dashboard.vapi.ai. New accounts get free trial credit.
2. **Create the assistant.** Go to **Assistants → Create Assistant → Blank Template** and name it `Bloom & Co. Receptionist`.
3. **Model tab:**
   - **First Message:** `Thanks for calling Bloom and Co. Hair Studio, this is Maya! How can I help you today?`
   - **System Prompt:** paste everything in `system-prompt.md`.
   - **Provider / Model:** OpenAI, `gpt-4o`. Set **Temperature** to `0.4`.
4. **Voice tab:** Provider `Vapi`, voice `Savannah` (or any voice you like).
5. **Transcriber tab:** Deepgram, `nova-2`, English.
6. **Advanced tab** (optional): turn on **End Call Function**. Set **End Call Message** to `Thanks for calling Bloom and Co. Have a beautiful day!`. Set max call duration to 600 seconds.
7. Click **Publish**, then click **Talk to Assistant** to test it in your browser.
8. **Get the phone number.** Go to **Phone Numbers → Create Phone Number → Free Vapi Number**. Enter an area code (try `407` for Orlando; if none are free, try another), then create it.
9. Open the new number, set **Inbound Settings → Assistant** to `Bloom & Co. Receptionist`, and save.
10. Call the number from your phone. New numbers can take a few minutes to start working.

> Vapi's free numbers are US-only and limited to a few per account. If you can't get one, buy or import a Twilio number under **Phone Numbers**.

## Faster option: the script

If you have `curl` and `jq`, this does steps 2 to 9 in one go. Copy your **private** key from **Dashboard → API Keys** first.

```bash
VAPI_API_KEY=your-private-key ./create-agent.sh 407
```

It prints the phone number when it's done. Don't commit your API key to this repo.

## After a call

Open **Call Logs** in the Vapi dashboard to see each call's recording, transcript, summary and cost. Screenshots of these make good evidence for the assignment.

## Changing the business

Everything about the salon lives in `system-prompt.md` under "Salon facts". Edit it, paste the new version into the dashboard, and publish again.

# SongForge — AI Music Generator

A single-page web app for generating songs with the [Suno API](https://docs.sunoapi.org). It's plain HTML, CSS and JavaScript, with no build step and no backend.

## Features
- **Simple mode**: describe a song in plain words (up to 500 characters) and the AI writes the lyrics and music.
- **Custom mode**: set the title, the style/genre (with quick-add tags) and your own lyrics.
- **AI lyrics writer**: turns a short idea into full lyrics you can edit.
- **Instrumental toggle**, a **model picker** (V6, V6 Wild, V6 Mini, plus older models), and advanced options: vocal gender, styles to exclude, style adherence and weirdness.
- **Live progress** that polls the API. You can play a streaming preview before the final MP3 is ready.
- **Library** saved in your browser, with a player, cover art, lyrics, download, reuse-in-custom-mode and delete for each song.
- **Remaining credits** shown in the header.

## API key
Each user pastes their own Suno API key under ⚙️ Settings. You can get one at https://sunoapi.org/api-key.
The key is saved only in that browser's `localStorage` and is sent only to `api.sunoapi.org`. **No key is stored in this repo.**

## Deploy to Netlify
1. In Netlify choose **Add new site → Import an existing project**, then pick this repo and the `main` branch.
2. Leave the build command empty. Netlify reads `netlify.toml`, which sets the publish directory to `public`.
3. Deploy. You can also drag the `public/` folder onto https://app.netlify.com/drop.

## Run locally
Serve the `public/` folder with any static server, for example `npx serve public`, then open the URL it prints.

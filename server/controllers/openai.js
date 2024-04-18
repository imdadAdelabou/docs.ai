import { config } from "dotenv";
config();
import OpenAI from "openai";

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

async function summarize(req, res) {
  try {
    const { text } = req.body;

    if (!text || text === "") {
      return res.status(400).json({ message: "No text to summarize" });
    }

    const response = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant.",
        },
        {
          role: "user",
          content: `Summarize the following text:\n${text}`,
        },
      ],
    });

    return res.status(200).json({ data: response.choices[0].message.content });
  } catch (e) {
    return res.status(500).send(e);
  }
}

async function generate_image(req, res) {
  try {
    const { prompt } = req.body;

    if (!prompt || prompt === "") {
      return res.status(400).json({ message: "No prompt to generate image" });
    }

    const response = await openai.images.generate({
      model: "dall-e-2",
      prompt: prompt,
      size: "1024x1024",
      quality: "standard",
    });

    if (!response.data.url) {
      return res.status(500).json({ message: "Failed to generate image" });
    }

    return res.status(200).json({ data: response.data.url });
  } catch (e) {
    return res.status(500).send(e);
  }
}

export { summarize, generate_image };

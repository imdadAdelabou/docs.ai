import OpenAI from 'openai';

const openai = new OpenAI(process.env.OPENAI_API_KEY);

async function summarize(req, res) {
  try {
    const { text } = req.body;

    if (!text || text === "") {
      return res.status(400).json({ message: "No text to summarize" });
    }

    const response = await openai.chat.completions.create({
      model: 'gpt-3.5-turbo',
      messages: [
        {
          role: 'system',
          content: 'You are a helpful assistant.'
        },
        {
          role: 'user',
          content: `Summarize the following text:\n${text}`
        }
      ]
    });

    return res.status(200).json({ data: response.data });
  } catch (e) {
    return res.status(500).send(e);
  }
};

async function generate_image(req, res) {
  try {
    const { prompt } = req.body;

    if (!prompt || prompt === "") {
      return res.status(400).json({ message: "No prompt to generate image" });
    }

    const response = await openai.images.create({
      model: 'clip-vit-base',
      prompt: text,
      width: 224,
      height: 224
    });

    return res.status(200).json({ data: response.data });
  } catch (e) {
    return res.status(500).send(e);
  }
}

export { summarize, generate_image };

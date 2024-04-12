import { Router } from 'express';
import { summarize, generate_image } from '../controllers/openai.js';

const openaiRouter = Router();

openaiRouter.post("/summarize", summarize);

openaiRouter.post("/gen_image", generate_image);

export default openaiRouter;

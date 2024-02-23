import { Router } from "express";
import { me, signUp } from "../controllers/auth.js";
import auth from "../middlewares/auth.midldleware.js";

const authRouter = Router();

authRouter.post('/signup', signUp);
authRouter.get('/me', auth, me);

export default authRouter;
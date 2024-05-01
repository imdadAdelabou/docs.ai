import { Router } from "express";
import {
  me,
  signUp,
  registerWithEmailAndPassword,
} from "../controllers/auth.js";
import auth from "../middlewares/auth.midldleware.js";

const authRouter = Router();

authRouter.post("/signup", signUp);
authRouter.post(
  "/register-with-email-and-password",
  registerWithEmailAndPassword
);
authRouter.get("/me", auth, me);

export default authRouter;

import { Router } from "express";
import { update } from "../controllers/user.js";

const userRouter = Router();

userRouter.put("/", update);

export default userRouter;

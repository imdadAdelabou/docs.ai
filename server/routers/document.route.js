import { Router } from "express";
import auth from "../middlewares/auth.midldleware.js";
import { create } from "../controllers/document.js";

const documentRouter = Router();

documentRouter.post("/doc/create", auth, create);

export default documentRouter;

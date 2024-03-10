import { Router } from "express";
import auth from "../middlewares/auth.midldleware.js";
import { create, me } from "../controllers/document.js";

const documentRouter = Router();

documentRouter.post("/doc/create", auth, create);
documentRouter.get("/doc/me", auth, me);

export default documentRouter;

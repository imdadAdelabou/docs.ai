import { Router } from "express";
import auth from "../middlewares/auth.midldleware.js";
import {
  create,
  getDocById,
  me,
  updateTitle,
} from "../controllers/document.js";

const documentRouter = Router();

documentRouter.post("/doc/create", auth, create);
documentRouter.get("/doc/me", auth, me);
documentRouter.put("/doc/title", auth, updateTitle);
documentRouter.get("/doc/:id", auth, getDocById);

export default documentRouter;

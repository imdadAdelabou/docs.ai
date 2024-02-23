import express from "express";
import { config } from "dotenv";
import cors from "cors";
config();
import mongoose from "mongoose";
import authRouter from "./routers/auth.route.js";


const app = express();

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;
const MONGODB_URI = process.env.MONGODB_URI;

app.use('/api', authRouter);

mongoose
  .connect(MONGODB_URI)
  .then(() => console.log("DB SUCCESS"))
  .catch((e) => console.log("DB ERROR " + e));

app.listen(PORT, "0.0.0.0", () => console.log("Server started"));

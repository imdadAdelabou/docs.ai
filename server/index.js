import { config } from "dotenv";
config();
import express from "express";

import http from "http";
import socket from "socket.io";
import cors from "cors";
import mongoose from "mongoose";
import auth from "./middlewares/auth.midldleware.js";
import authRouter from "./routers/auth.route.js";
import documentRouter from "./routers/document.route.js";
import { updateDocument } from "./controllers/document.js";
import userRouter from "./routers/user.route.js";
import openaiRouter from "./routers/openai.route.js";

const app = express();
const httpServer = http.createServer(app);
const socketConfig = socket(httpServer);

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;
const MONGODB_URI = process.env.MONGODB_URI;

app.use("/api", authRouter);
app.use("/api", documentRouter);
app.use("/api/user", auth, userRouter);
app.use("/api/openai", openaiRouter);

mongoose
  .connect(MONGODB_URI)
  .then(() => console.log("DB SUCCESS"))
  .catch((e) => console.log("DB ERROR " + e));

socketConfig.on("connection", (socketIn) => {
  socketIn.on("join", (documentId) => {
    socketIn.join(documentId);
    console.log("joined!");
  });

  socketIn.on("typing", (data) => {
    // To send a data via the channel changes to all of the user inside the room execpt
    // the user that emit the request
    socketIn.broadcast.to(data.room).emit("changes", data);
  });

  socketIn.on("save", (data) => {
    updateDocument(data);
  });
});
httpServer.listen(PORT, "0.0.0.0", () => console.log("Server started"));

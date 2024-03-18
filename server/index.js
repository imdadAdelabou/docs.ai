import express from "express";
import http from "http";
import socket from "socket.io";
import { config } from "dotenv";
import cors from "cors";
config();
import mongoose from "mongoose";
import authRouter from "./routers/auth.route.js";
import documentRouter from "./routers/document.route.js";
import { updateDocument } from "./controllers/document.js";

const app = express();
const httpServer = http.createServer(app);
const socketConfig = socket(httpServer);

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;
const MONGODB_URI = process.env.MONGODB_URI;

app.use("/api", authRouter);
app.use("/api", documentRouter);

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

import mongoose from "mongoose";

const userSchema = mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, trim: true },
  photoUrl: { type: String, required: false, trim: true },
  password: { type: String, required: false, trim: true },
  provider: { type: String, required: true, trim: true },
});

const User = mongoose.model("User", userSchema);

export default User;

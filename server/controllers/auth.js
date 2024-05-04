import User from "../models/user.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

async function signUp(req, res) {
  try {
    //TODO: implement validation on user input
    const { email, name, photoUrl, provider } = req.body;
    console.log(provider);
    let user = await User.findOne({ email });
    let isNewUser = false;

    if (!user) {
      user = new User({ name, email, photoUrl, provider });
      user = await user.save();
      isNewUser = true;
    }

    const token = jwt.sign({ id: user._id }, process.env.JWTPRIVATEKEY);
    return res
      .status(201)
      .json({ message: "User created", user: user, token: token, isNewUser });
  } catch (e) {
    return res.status(500).json({ message: "Internal Server error", error: e });
  }
}

async function registerWithEmailAndPassword(req, res) {
  try {
    const { email, password, name } = req.body;
    let user = await User.findOne({ email });
    if (user) {
      return res.status(409).json({ message: "User already exists" });
    }
    const salt = await bcrypt.genSaltSync(Number(process.env.SALT_ROUNDS));
    const hashedPassword = await bcrypt.hash(password, salt);
    user = new User({
      email,
      password: hashedPassword,
      name,
      provider: "EMAIL/PASSWORD",
    });
    user = await user.save();

    const token = jwt.sign({ id: user._id }, process.env.JWTPRIVATEKEY);
    return res.status(201).json({ message: "User created", user, token });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal Server error", error: e });
  }
}

async function loginWithEmailAndPassword(req, res) {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const isPasswordCorrect = await bcrypt.compare(password, user.password);

    if (!isPasswordCorrect) {
      return res.status(401).json({ message: "Invalid password" });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWTPRIVATEKEY);
    return res.status(200).json({
      message: "User login successful",
      user: user,
      token: token,
      isNewUser: false,
    });
  } catch (error) {
    return res.status(500).json({ message: "Internal Server error", error });
  }
}

async function me(req, res) {
  try {
    const userId = req.userId;
    const token = req.token;
    const user = await User.findById(userId.id);

    return res.status(200).json({ message: "Success", user, token });
  } catch (e) {
    return res.status(500).json({ message: "Internal Server error", error: e });
  }
}

export { signUp, me, registerWithEmailAndPassword, loginWithEmailAndPassword };

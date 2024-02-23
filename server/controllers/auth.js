import User from "../models/user.js";
import jwt from 'jsonwebtoken';

async function signUp(req, res, next) {
  try {
    //TODO: implement validation on user input
    const { email, name, photoUrl } = req.body;
    let user = await User.findOne({ email });
    if (!user) {
      user = new User({ name, email, photoUrl });
      user = await user.save();
    }

    const token = jwt.sign({id: user._id}, process.env.JWTPRIVATEKEY);
    return res.status(201).json({ message: "User created", user: user, token: token });
  } catch (e) {
    console.log(e);
    return (
      res.status(500).json({ message: "Internal Server error", error: e })
    );
  }
}

function me(req, res, next) {
  const {userId} = req.body;

  return res.status(200).json({message: "Success", user: userId});
}

export { signUp, me };

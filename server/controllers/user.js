import User from "../models/user.js";

async function update(req, res) {
  try {
    let user = await User.findByIdAndUpdate(req.userId.id, req.body, {
      new: true,
    });

    return res.status(200).json({ message: "Success", user });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Internal Server error", error: error });
  }
}

export { update };

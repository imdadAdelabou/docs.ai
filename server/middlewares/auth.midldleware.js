import jwt from "jsonwebtoken";

async function auth(req, res, next) {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ message: "No token passed." });
    }

    const isVerified = jwt.verify(token, process.env.JWTPRIVATEKEY);
    if (!isVerified)
      return res.status(401).json({ message: "Incorrect token" });

    req.userId = isVerified;
    req.token = token;
    next();
  } catch (e) {
    return res.status(500).json({message: "Internal Server Error"});
  }
}

export default auth;

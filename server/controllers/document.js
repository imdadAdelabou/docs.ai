import Document from "../models/document.js";

//TODO: Ajouter une couche de validation
//des données client en utilisant Jotai ou express validator
async function create(req, res) {
  try {
    const { createdAt, content } = req.body;
    const uid = req.userId.id;

    let doc = new Document({
      title: "Untitled Document",
      content,
      createdAt,
      uid,
    });
    doc = await doc.save();
    return res.status(201).json({ message: "Document created", document: doc });
  } catch (e) {
    return res.status(500).json({ message: "Internal Server", error: e });
  }
}

export { create };

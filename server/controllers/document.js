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

async function me(req, res) {
  try {
    const documents = await Document.find({ uid: req.userId.id });
    if (documents.length <= 0) {
      return res.status(200).json({ message: "No document to display" });
    }

    return res.status(200).json({ message: "Success", documents });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal Server", error: e });
  }
}

export { create, me };

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

async function updateTitle(req, res) {
  try {
    const { id, title } = req.body;
    const document = await Document.findByIdAndUpdate(id, { title });
    if (!document) {
      return res.status(404).json({ message: "No document found" });
    }

    return res.status(200).json({ message: "Success", document });
  } catch (e) {
    return res.status(500).json({ message: "Internal Server", error: e });
  }
}

async function getDocById(req, res) {
  try {
    const { id } = req.params.id;
    console.log(req.params.id);
    const document = await Document.findById({ _id: req.params.id });

    if (!document) {
      return res.status(404).json({ message: "No document found" });
    }

    console.log(document);
    return res.status(200).json({ message: "Success", document });
  } catch (e) {
    console.log(e);
    return res.status(500).json({ message: "Internal Server", error: e });
  }
}

async function updateDocument(data) {
  try {
    let document = await Document.findById(data.id);
    if (!document) {
      return "No document found";
    }
    document.content = data.delta;
    document = await document.save();
  } catch (e) {
    console.log(e);
    return;
  }
}

export { create, me, updateTitle, getDocById, updateDocument };

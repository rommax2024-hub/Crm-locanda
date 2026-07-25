require("dotenv").config();
const express = require("express");
const cors = require("cors");

const clientsRouter = require("./src/routes/clients");
const reservationsRouter = require("./src/routes/reservations");

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ status: "ok", message: "CRM Locanda Magna Sesterzi - backend attivo" });
});

app.use("/api/clients", clientsRouter);
app.use("/api/reservations", reservationsRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server avviato sulla porta ${PORT}`);
});

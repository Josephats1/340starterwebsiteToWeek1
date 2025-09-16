const baseController = require("./controllers/baseControllers");

// Index Route
app.get("/", baseController.buildHome)
const app = require('express')();

app.get('/', (req, res) => {
  res.json({ message: 'Docker is easy'});
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
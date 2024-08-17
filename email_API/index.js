const express = require('express');
const nodemailer = require('nodemailer');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// Cấu hình transporter cho nodemailer với tài khoản Gmail
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'your-email@gmail.com', // Thay bằng email của bạn
    pass: 'your-email-password',  // Thay bằng mật khẩu ứng dụng
  },
});

// Route để gửi email
app.post('/send-email', (req, res) => {
  const { subject, body, recipient } = req.body;

  const mailOptions = {
    from: 'your-email@gmail.com', // Thay bằng email của bạn
    to: recipient,
    subject: subject,
    text: body,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      res.status(500).send('Gửi email không thành công');
    } else {
      console.log('Email sent: ' + info.response);
      res.status(200).send('Email đã được gửi thành công');
    }
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

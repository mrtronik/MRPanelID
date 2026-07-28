const nodemailer = require('nodemailer');

function createTransporter(session) {
    const host = session.smtpHost || process.env.SMTP_HOST || 'localhost';
    const port = parseInt(session.smtpPort) || parseInt(process.env.SMTP_PORT) || 25;
    const secure = session.smtpSecure !== undefined ? session.smtpSecure : (process.env.SMTP_SECURE === 'true');

    const config = {
        host,
        port,
        secure,
        tls: {
            rejectUnauthorized: false
        }
    };

    const user = session.smtpUser || process.env.SMTP_USER;
    const pass = session.smtpPass || process.env.SMTP_PASS;

    if (user && pass) {
        config.auth = {
            user,
            pass
        };
    }

    console.log("SMTP CONFIG:", config);
    console.log("SESSION:", session);

    return nodemailer.createTransport(config);
}
async function sendMail(session, { to, subject, text, html, cc, bcc, attachments }) {
    const transport = createTransporter(session);
    const info = await transport.sendMail({
        from: session.userEmail || process.env.SMTP_USER || 'noreply@localhost',
        to,
        subject,
        text,
        html,
        cc,
        bcc,
        attachments
    });
    return info;
}

async function verifyConnection(session) {
    const transport = createTransporter(session);
    await transport.verify();
}

module.exports = { sendMail, verifyConnection };

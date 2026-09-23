import "server-only";

import { Resend } from "resend";

const LOG_EMAIL_FROM = "Recollect It <logs@recollectit.wadecherry.us>";
const LOG_EMAIL_SUBJECT = "New log added to Recollect It";

export async function sendLogEmail(message: string): Promise<void> {
  try {
    const apiKey = process.env.RESEND_API_KEY;
    const to = process.env.LOG_EMAIL_TO;

    if (!apiKey || !to) {
      throw new Error(
        "RESEND_API_KEY and LOG_EMAIL_TO must be configured to send log notification emails.",
      );
    }

    const resend = new Resend(apiKey);
    const { error } = await resend.emails.send({
      from: LOG_EMAIL_FROM,
      to,
      subject: LOG_EMAIL_SUBJECT,
      text: message,
    });

    if (error) {
      throw new Error(`Resend returned ${error.name}: ${error.message}`);
    }
  } catch (error) {
    console.error("Failed to send log notification email through Resend.", error);
  }
}

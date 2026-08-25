import { clearCurrentStudentCookie } from "@/server/student-identity";
import { logUnexpectedError } from "@/server/logs";

export const runtime = "nodejs";

export async function POST(request: Request): Promise<Response> {
  try {
    await clearCurrentStudentCookie();

    return Response.redirect(new URL("/", request.url), 303);
  } catch (error) {
    try {
      await logUnexpectedError("POST /api/logout failed", error);
    } catch {
      // A logging failure must not expose or replace the generic API response.
    }

    return Response.json(
      {
        error: {
          code: "INTERNAL_ERROR",
          message: "Something went wrong. Please try again.",
        },
      },
      { status: 500 },
    );
  }
}

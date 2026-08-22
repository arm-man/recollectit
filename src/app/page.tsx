import { redirect } from "next/navigation";

import { StudentAccessForm } from "@/app/StudentAccessForm";
import { getCurrentStudent } from "@/server/student-identity";

export default async function Home() {
  const student = await getCurrentStudent();

  if (student) {
    redirect("/landing");
  }

  return <StudentAccessForm />;
}

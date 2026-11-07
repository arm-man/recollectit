import type { Metadata } from "next";
import { redirect } from "next/navigation";

import { StudentAccessForm } from "@/app/StudentAccessForm";
import { getCurrentStudent } from "@/server/student-identity";

export const metadata: Metadata = {
  title: "Recollect It – Free Online Flashcards & Study Tool",
};

export default async function Home() {
  const student = await getCurrentStudent();

  if (student) {
    redirect("/landing");
  }

  return <StudentAccessForm />;
}

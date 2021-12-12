import { mailGroupItem } from "@/types/mail-groups";

const mockMailGroups: mailGroupItem[] = [
  {
    id: "123",
    title: "Przykładowa kampania",
    description: "Opis kampani tu jest",
    subject: "Tytuł maila",
    body: "Przykładowy text",
  },
  {
    id: "456",
    title: "Inna kampania",
    body: "Inny tekst",
  },
  {
    id: "de6712a1-11fc-4b87-be7b-d03f3bbf737b",
    title: "Welcome campaign",
    description: "Campaiagn to welcome customers",
    subject: "Welcome",
    body: "Hello {{var:name}}, {{var:surname}}. We would like to welcome you!",
  },
];

export default mockMailGroups;

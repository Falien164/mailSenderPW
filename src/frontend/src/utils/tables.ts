import { mailGroupItem } from "@/types/mail-groups";
import { clientItem } from "@/types/clients";

export const mailGroupTable = [
  {
    name: "title",
    required: true,
    label: "Nazwa kampani",
    align: "left",
    field: (row: mailGroupItem): string => row.title,
    format: (val: string): string => `${val}`,
    sortable: true,
  },
  {
    name: "description",
    label: "Opis",
    align: "left",
    field: (row: mailGroupItem): string | undefined => row.description,
    format: (val: string | undefined): string => val || "-",
    sortable: true,
  },
  {
    name: "subject",
    label: "Tytuł maila",
    align: "left",
    field: (row: mailGroupItem): string | undefined => row.subject,
    format: (val: string | undefined): string => val || "-",
    sortable: true,
  },
  {
    name: "actions",
    align: "center",
    label: "Akcje",
  },
];

export const clientTable = [
  {
    name: "sent",
    align: "center",
    label: "Wysłane",
  },
  {
    name: "name",
    label: "Imie",
    align: "left",
    field: (row: clientItem): string | undefined => row.name,
    format: (val: string | undefined): string => val || "-",
    sortable: true,
  },
  {
    name: "surname",
    label: "Nazwisko",
    align: "left",
    field: (row: clientItem): string | undefined => row.surname,
    format: (val: string | undefined): string => val || "-",
    sortable: true,
  },
  {
    name: "email",
    label: "Email",
    align: "left",
    field: (row: clientItem): string | undefined => row.email,
    format: (val: string | undefined): string => val || "-",
    sortable: true,
  },
  {
    name: "actions",
    align: "center",
    label: "Akcje",
  },
];

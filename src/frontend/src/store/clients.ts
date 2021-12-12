import { Notify } from "quasar";
import { Store } from ".";
import http from "@/utils/http";
import { clientItem } from "@/types/clients";
import { mailItem } from "@/types/mail";

interface Clients extends Object {
  clientItems: Record<string, clientItem[]>;
  sent: Record<string, string[]>;
}

const errorMap: Record<string, string> = {
  401: "Sesja wygasła",
  404: "Serwer nieosiągalny",
  422: "Źle uzupełnione dane",
};

class ClientStore extends Store<Clients> {
  protected data(): Clients {
    return {
      clientItems: {},
      sent: {},
    };
  }

  async retrieveClients(id: string) {
    if (!id) {
      return;
    }

    if (
      this.state?.clientItems?.[id]?.length &&
      this.state?.clientItems?.[id]?.length !== 0
    ) {
      return this.state.clientItems[id];
    }

    const clients: clientItem[] = (await http
      .get(`email_campaigns/${id}/clients`)
      .then((val) => val.data)) as clientItem[];
    this.state.clientItems[id] = clients;
    return clients;
  }

  async addClient(id: string, client: clientItem) {
    try {
      const result = (await http
        .post(`email_campaigns/${id}/add_client`, { client })
        .then((res) => res.data)) as clientItem;

      this.state.clientItems[id].push(result);
      return result;
    } catch (error: any) {
      Notify.create({
        type: "negative",
        message: errorMap[error.response.status] || "Nieoczekiwany błąd",
        position: "top-right",
      });
      throw error;
    }
  }

  async removeClient(id: string, client: clientItem) {
    try {
      const result = (await http
        .delete(`email_campaigns/${id}/delete_client`, { data: { client } })
        .then((res) => res.data)) as clientItem;

      this.state.clientItems[id].splice(
        this.state.clientItems[id].findIndex(
          (item: clientItem) => item.id === result.id
        ),
        1
      );
      return result;
    } catch (error: any) {
      Notify.create({
        type: "negative",
        message: errorMap[error.response.status] || "Nieoczekiwany błąd",
        position: "top-right",
      });
      throw error;
    }
  }

  async retrieveMails(id: string): Promise<string[]> {
    return http
      .get(`email_campaigns/${id}/mails`)
      .then((val) => val.data.map((el: mailItem) => el.client_id));
  }
}

export const clientStore = new ClientStore();

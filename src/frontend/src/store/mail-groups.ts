import { Notify } from "quasar";
import { Store } from ".";
import http from "@/utils/http";
import { mailGroupItem } from "@/types/mail-groups";
import { mailItem } from "@/types/mail";

interface MailGroups extends Object {
  mailGroupItems: mailGroupItem[];
  mails: Record<string, mailItem[]>;
}

const errorMap: Record<string, string> = {
  401: "Sesja wygasła",
  404: "Serwer nieosiągalny",
  422: " Źle uzupełnione dane",
};

class MailGroupsStore extends Store<MailGroups> {
  protected data(): MailGroups {
    return {
      mailGroupItems: [],
      mails: {},
    };
  }

  async retrieveMailCampaigns() {
    if (this.state.mailGroupItems.length !== 0) {
      return this.state.mailGroupItems;
    }

    const mailGroups: mailGroupItem[] = (await http
      .get("email_campaigns")
      .then((val) => val.data)) as mailGroupItem[];
    this.state.mailGroupItems = mailGroups;
    return mailGroups;
  }

  async addMailCampaign(mailCampaign: mailGroupItem) {
    try {
      const result = (await http
        .post("email_campaigns", mailCampaign)
        .then((res) => res.data)) as mailGroupItem;

      this.state.mailGroupItems.push(result);
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

  async editMailCampaign(mailCampaign: mailGroupItem) {
    try {
      const result = (await http
        .put(`email_campaigns/${mailCampaign.id}`, mailCampaign)
        .then((res) => res.data)) as mailGroupItem;

      this.state.mailGroupItems.splice(
        this.state.mailGroupItems.findIndex(
          (item: mailGroupItem) => item.id === result.id
        ),
        1,
        result
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

  async removeMailCampaign(mailCampaign: mailGroupItem) {
    try {
      const result = (await http
        .delete(`email_campaigns/${mailCampaign.id}`)
        .then((res) => res.data)) as mailGroupItem;

      this.state.mailGroupItems.splice(
        this.state.mailGroupItems.findIndex(
          (item: mailGroupItem) => item.id === result.id
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

  async sendMail(mailCampaign: mailGroupItem) {
    try {
      await http.post(`email_campaigns/${mailCampaign.id}/send_mails`);
      Notify.create({
        type: "positive",
        message: "Maile wysłane",
        position: "top-right",
      });
    } catch (error) {
      Notify.create({
        type: "negative",
        message: "Nieoczekiwany błąd",
        position: "top-right",
      });
      throw error;
    }
  }
}

export const mailGroupsStore = new MailGroupsStore();

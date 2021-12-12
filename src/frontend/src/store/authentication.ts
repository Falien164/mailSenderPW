import { Notify } from "quasar";
import { Store } from ".";
import axios from "axios";

const authService = "https://cloud-service-backend.azurewebsites.net/sign_in";
const registerService =
  "https://cloud-service-backend.azurewebsites.net/sign_up";

const errorMap: Record<string, string> = {
  401: "Błędne dane logowania",
  404: "Serwer nieosiągalny",
};

interface User extends Object {
  token: string;
}

class AuthenticationStore extends Store<User> {
  protected data(): User {
    return {
      token: localStorage.getItem("auth") || "",
    };
  }

  async authenticate(email: string, password: string) {
    try {
      const token = (await axios
        .post(authService, { user: { email, password } })
        .then((val) => val.data.auth_token)) as string;
      this.state.token = token;
      localStorage.setItem("auth", token);
      return token;
    } catch (error: any) {
      Notify.create({
        type: "negative",
        message: errorMap[error.response.status] || "Nieoczekiwany błąd",
        position: "top-right",
      });
      throw error;
    }
  }

  clearToken() {
    this.state.token = "";
  }

  async register(email: string, password: string) {
    try {
      await axios.post(registerService, {
        user: { name: "", email, password, password_confirmation: password },
      });
      return this.authenticate(email, password);
    } catch (error: any) {
      Notify.create({
        type: "negative",
        message: errorMap[error.response.status] || "Nieoczekiwany błąd",
        position: "top-right",
      });
      throw error;
    }
  }
}

export const authenticationStore = new AuthenticationStore();

import axios from "axios";
import { authenticationStore } from "@/store/authentication";

const http = axios.create({
  baseURL: "https://cloud-service-backend.azurewebsites.net",
  headers: {
    authorization: authenticationStore.getState().token,
  },
});

http.interceptors.response.use(
  (res) => res,
  (error) => {
    if (error.response.status === 401) {
      authenticationStore.clearToken();
    }
    return Promise.reject(error);
  }
);

export default http;

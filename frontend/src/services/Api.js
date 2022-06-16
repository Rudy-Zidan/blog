import axios from "axios"
import router from '@/router'

export default () => {
  let instance = axios.create({
    baseURL: process.env.VUE_APP_BASE_API_URL,
    withCredentials: false,
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json"
    }
  });

  instance.interceptors.response.use(
    response => {
      return response;
    },
    error => {
      if (error.response && error.response.status > 400) {
        
        router.push("/404")
      }

      return Promise.reject(error);
    }
  );

  return instance;
};
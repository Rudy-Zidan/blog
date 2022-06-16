import axios from "axios";

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
      if (error.response && error.response.data.status > 400) {
        console.log(error.response)
      }

      return Promise.reject(error);
    }
  );

  return instance;
};
import axios from 'axios'

const BASE_URL = 'http://127.0.0.1:8000'

const instance = axios.create({
    baseURL: BASE_URL,
  });

export default {
    get:instance.get,
    post:instance.post
}
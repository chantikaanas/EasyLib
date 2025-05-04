import API_CONFIG from "../config/api.config";

class HttpClient {
  constructor() {
    this.baseUrl = API_CONFIG.BASE_URL;
    this.headers = API_CONFIG.HEADERS;
  }

  // Add auth token to headers if available
  setAuthToken(token) {
    if (token) {
      this.headers = {
        ...this.headers,
        Authorization: `Bearer ${token}`,
      };
    }
  }

  // GET request
  async get(endpoint, params = {}) {
    const url = new URL(`${this.baseUrl}${endpoint}`);
    Object.keys(params).forEach((key) =>
      url.searchParams.append(key, params[key])
    );

    const response = await fetch(url, {
      method: "GET",
      headers: this.headers,
    });

    return this._handleResponse(response);
  }

  // POST request
  async post(endpoint, data = {}) {
    const response = await fetch(`${this.baseUrl}${endpoint}`, {
      method: "POST",
      headers: this.headers,
      body: JSON.stringify(data),
    });

    return this._handleResponse(response);
  }

  // Handle API response
  async _handleResponse(response) {
    const data = await response.json();

    if (!response.ok) {
      const error = {
        status: response.status,
        message: data.message || "Something went wrong",
        errors: data.errors || {},
      };
      throw error;
    }

    return data;
  }
}

export default new HttpClient();

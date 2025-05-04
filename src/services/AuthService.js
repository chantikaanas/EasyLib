import HttpClient from "./HttpClient";
import API_CONFIG from "../config/api.config";

class AuthService {
  /**
   * Register a new user
   * @param {Object} userData - User registration data
   * @returns {Promise} - Promise with registration result
   */
  async register(userData) {
    try {
      const response = await HttpClient.post(
        API_CONFIG.ENDPOINTS.REGISTER,
        userData
      );

      if (response.data && response.data.token) {
        this._saveToken(response.data.token);
        this._saveUser(response.data.user);
      }

      return response;
    } catch (error) {
      console.error("Registration error:", error);
      throw error;
    }
  }

  /**
   * Login user with credentials
   * @param {Object} credentials - User login credentials
   * @returns {Promise} - Promise with login result
   */
  async login(credentials) {
    try {
      const response = await HttpClient.post(
        API_CONFIG.ENDPOINTS.LOGIN,
        credentials
      );

      if (response.data && response.data.token) {
        this._saveToken(response.data.token);
        this._saveUser(response.data.user);
      }

      return response;
    } catch (error) {
      console.error("Login error:", error);
      throw error;
    }
  }

  /**
   * Logout current user
   * @returns {Promise} - Promise with logout result
   */
  async logout() {
    try {
      // Make sure we have the token in headers before logout request
      const token = this.getToken();
      if (token) {
        HttpClient.setAuthToken(token);
      }

      const response = await HttpClient.post(API_CONFIG.ENDPOINTS.LOGOUT);

      // Clear stored user data
      this._clearUserData();

      return response;
    } catch (error) {
      console.error("Logout error:", error);
      // Even if the request fails, clear user data
      this._clearUserData();
      throw error;
    }
  }

  /**
   * Check if user is authenticated
   * @returns {Boolean} - Authentication status
   */
  isAuthenticated() {
    return !!this.getToken();
  }

  /**
   * Get current user data
   * @returns {Object|null} - User data or null
   */
  getCurrentUser() {
    const userStr = localStorage.getItem("user");
    return userStr ? JSON.parse(userStr) : null;
  }

  /**
   * Get authentication token
   * @returns {String|null} - Auth token or null
   */
  getToken() {
    return localStorage.getItem("token");
  }

  // Private methods
  _saveToken(token) {
    localStorage.setItem("token", token);
    HttpClient.setAuthToken(token);
  }

  _saveUser(user) {
    localStorage.setItem("user", JSON.stringify(user));
  }

  _clearUserData() {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
  }
}

export default new AuthService();

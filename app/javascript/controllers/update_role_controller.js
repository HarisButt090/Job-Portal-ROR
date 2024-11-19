import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["frame"];

  async update(event) {
    const selectedRole = event.target.value;

    // Fetch the corresponding partial
    const response = await fetch(`/registrations/role_details?role=${selectedRole}`, {
      headers: { "Accept": "text/html" },
    });

    if (response.ok) {
      const html = await response.text();
      this.frameTarget.innerHTML = html;
    } else {
      this.frameTarget.innerHTML = ""; // Clear content if no fields are needed
      console.error("Error fetching partial");
    }
  }
}

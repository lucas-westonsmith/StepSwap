import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate", "endDate", "totalPrice"];
  static values = { pricePerDay: Number };

  connect() {
    console.log("Booking controller connected");
  }

  calculateTotal() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);

    if (startDate && endDate && endDate > startDate) {
      const diffTime = Math.abs(endDate - startDate);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // Convert milliseconds to days
      const total = diffDays * this.pricePerDayValue;

      this.totalPriceTarget.textContent = total.toFixed(2);
    } else {
      this.totalPriceTarget.textContent = "0.00";
    }
  }
}

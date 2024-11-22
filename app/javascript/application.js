// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

$(document).ready(function(){


});



import { Application } from "@hotwired/stimulus";
import BookingController from "./controllers/booking_controller";

const application = Application.start();
application.register("booking", BookingController);

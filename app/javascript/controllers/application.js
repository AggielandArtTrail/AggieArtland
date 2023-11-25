//= require jquery
//= require jquery_ujs
//= require jquery3
//= require popper
//= require bootstrap

import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

// Connects to data-controller="geolocation"
export default class extends Controller {
  connect() {
    this.search()
  }

  success(pos) {
    const crd = pos.coords;

    document.getElementById("lat").innerHTML = crd.latitude
    document.getElementById("long").innerHTML = crd.longitude
    document.getElementById("acc").innerHTML = crd.accuracy

    console.log('Your current position is:');
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less ${crd.accuracy} meters.`);
    // location.assign(`/locations?place=${crd.latitude},${crd.longitude}`)

    $.post("map/updateloc",{latitude: crd.latitude, longitude: crd.longitude, accuracy: crd.accuracy}, function(data, status){
      // console.log("status: " + status);
      // if(status == "success")
      // {
      //   alert(data);
      // } 
   });
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  search () {
    setInterval(() => {
      navigator.geolocation.getCurrentPosition(this.success, this.error, options);
    },1000)
  }
}
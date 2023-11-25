//= require jquery
//= require jquery_ujs

function initMap() {
  var latitude = parseFloat(document.getElementById('lat').textContent);
  var longitude = parseFloat(document.getElementById('long').textContent);

  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: latitude, lng: longitude},
    zoom: 15
  });

  var userMarker = new google.maps.Marker({
    position: {lat: latitude, lng: longitude},
    map: map,
    title: 'Your Location',
    icon: 'https://aggie-art-public.s3.us-east-2.amazonaws.com/red-dot.png'
  });

  if (typeof artPieces !== 'undefined' && Array.isArray(artPieces)) {
    var infoWindow = new google.maps.InfoWindow();

    artPieces.forEach(function(artPiece) {
      var marker = new google.maps.Marker({
        position: {lat: artPiece.latitude, lng: artPiece.longitude},
        map: map,
        title: artPiece.name,
            icon: {
      url: artPiece.get_icon, // The URL of the image file
      scaledSize: new google.maps.Size(32, 32) // Sets the icon size
    }
      });

      marker.addListener('click', function () {
        // var artImageUrl = '/assets/art_piece_icon_' + artPiece.id + '.png';
        // var defaultImageUrl = 'https://aggie-art-public.s3.us-east-2.amazonaws.com/default_art.png';
        var artImageUrl = artPiece.get_icon;

        var img = new Image();
        img.onload = function() {
          setInfoWindowContent(artImageUrl, artPiece, marker);
        };
        img.onerror = function() {
          setInfoWindowContent(defaultImageUrl, artPiece, marker);
        };
  
        img.src = artImageUrl;
      });

    });
  }

  function setInfoWindowContent(imageUrl, artPiece, marker) {
    var artPieceImage = '<img src="' + imageUrl + '" style="width: 100px; height: 100px;" />';
    var artPieceLink = '<a href="/art_pieces/' + artPiece.id + '">View Art Piece</a>';
    var checkinLink = '<a href="/art_pieces/checkin/' + artPiece.id + '">Check-in to Art Piece</a>';
    infoWindow.setContent(artPieceImage + '<br>' + "Art Piece: " + artPiece.name + '<br>' + artPieceLink + '<br>' + checkinLink);
    infoWindow.open(map, marker);
  }
}

function init() {
  navigator.geolocation.getCurrentPosition(function(position) {
      console.log("navigator geolocation success");

      document.getElementById('lat').textContent = position.coords.latitude;
      document.getElementById('long').textContent = position.coords.longitude;
      document.getElementById('acc').textContent = position.coords.accuracy;

      $.post("map/updateloc",{latitude: position.coords.latitude, longitude: position.coords.longitude, accuracy: position.coords.accuracy}, function(data, status){
          // console.log("status: " + status);
          // if(status == "success")
          // {
          //   alert(data);
          // } 
      });

      // Call the initMap function after getting the geolocation data
      initMap();
  }, function(error) {
    console.error("Geolocation failed: ", error);
  });
}
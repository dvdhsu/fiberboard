function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 51.5073509, lng: -0.12775829999998223},
    zoom: 13
  });

  var geocoder = new google.maps.Geocoder();

  document.getElementById('address').addEventListener('blur', function() {
    geocodeAddress(geocoder, map);
  });

  var input = (document.getElementById('name'));

  var autocomplete = new google.maps.places.Autocomplete(input);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Autocomplete's returned place contains no geometry");
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(13);
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    document.getElementById('address').value = place.formatted_address;

    var lng = place.geometry.location.lng();
    var lat = place.geometry.location.lat();
    document.getElementById('geopoint').value = "POINT(" + lng + " " + lat + ")";

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });
}

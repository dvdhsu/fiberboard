
CITY = 'London, UK' # Change me to get different cities

import foursquare
import csv

from foursquare_secrets import client_id, client_secret

client = foursquare.Foursquare(client_id=client_id, client_secret=client_secret)
results = client.venues.explore(params={'near': CITY, 'venuePhotos': 1, 'limit': 50})

items = results['groups'][0]['items']

csv_table = [['name', 'description', 'photo_url', 'address', 'lat', 'lng']]

for item in items:
  tips = item['tips'][0]
  venue = item['venue']

  name = venue['name'].encode('ascii', 'ignore')
  description = tips['text'].encode('ascii', 'ignore')
  photo_url = venue['featuredPhotos']['items'][0]['prefix'] + '400x300' + venue['featuredPhotos']['items'][0]['suffix']
  address = ', '.join(venue['location']['formattedAddress']).encode('ascii', 'ignore')
  lat,lng = venue['location']['lat'], venue['location']['lng']
  csv_table.append([name, description, photo_url, address, lat, lng])

with open('out.csv', 'wb') as fopen:
  writer = csv.writer(fopen)
  writer.writerows(csv_table)

import foursquare
import csv
import sys
import subprocess

from foursquare_secrets import client_id, client_secret

# parse command line args
if len(sys.argv) != 4:
  print '''
  Incorrect number of arguments - first argument should be the city name, and the second argument should be the id of the city
  e.g. `python importer.py "London, UK" 51.342 0.78
  '''
  sys.exit(2)
[_, CITY_NAME, LAT, LNG] = sys.argv

# run command to create new city
template_command ="""mix CreateCity "{CITY_NAME}" {LAT} {LNG} | grep 'NEW-CITY-ID' | cut -d "'" -f 2"""
CITY_ID = int(subprocess.check_output(template_command.format(CITY_NAME=CITY_NAME, LAT=LAT, LNG=LNG), shell=True))
print "Created a new city", CITY_NAME, "with city id:", CITY_ID

# grab data from foursquare
client = foursquare.Foursquare(client_id=client_id, client_secret=client_secret)
results = client.venues.explore(params={'near': CITY_NAME, 'venuePhotos': 1, 'limit': 50})
items = results['groups'][0]['items']

csv_table = [['city_id', 'attraction_category_id', 'name', 'description', 'image_url', 'address', 'lat', 'lng']]
for item in items:
  tips = item['tips'][0]
  venue = item['venue']

  name = venue['name'].encode('ascii', 'ignore')
  description = tips['text'].encode('ascii', 'ignore')
  photo_url = venue['featuredPhotos']['items'][0]['prefix'] + '400x300' + venue['featuredPhotos']['items'][0]['suffix']
  address = ', '.join(venue['location']['formattedAddress']).encode('ascii', 'ignore')
  lat,lng = venue['location']['lat'], venue['location']['lng']
  csv_table.append([CITY_ID, 1, name, description, photo_url, address, lat, lng])

with open('out.csv', 'wb') as fopen:
  writer = csv.writer(fopen)
  writer.writerows(csv_table)

# insert data into database
print subprocess.check_output("mix ImportAttractions out.csv", shell=True)

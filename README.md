# testMomentousDansTorre

This is a test for Momentous develop by Daniel Torres

The code have three main threads one for persistance, one for displaying the UI elements, and one for requesting elements
from a Web service.

the core data implemented here saves the image binary data received from the web service, along with other data related to
the request.

The app shows the images has they are downloading and you have the freedom to move around has they keep downloading.

You can search for an article in the table and collection view section, can delete from both table and collection 
view section.

The app sets the keys related to settings in the first launch and save the settings everytime
the user changes its options automatically.

There is a button refresh that is more like requesting the service again so the app can have more articles to the ones 
stored in core data. I didn't wanted to put a button that drops the db, more like Instagram, the app deletes a single 
or a bunch of articles selected by the user. 


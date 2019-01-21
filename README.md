# README

This api provides data of all the coffee shops in proximity of given latitude and longitude, scoped by the post code.

* Installation
  bundle install

* Configuration
  export MAPBOX_API_KEY

* How to run the test suite
  $ rake

* Examples
  $ curl http://localhost:3000/coffee_points?latitude=52.520008&longitude=13.404954

  ```
  {
    "coffee_points": [
      {
        "postcode":"10178",
        "coffee_shops": [
          {
            "name":"Coffee Fellows, Rosa-Luxemburg-Str. 2, Berlin, 10178, Germany"
          },
          {
            "name":"Balzac Coffee, Karl-Liebknecht-Str. 5, Berlin, 10178, Germany"
          },
          {
            "name":"Pure Origins, Litfaßplatz 2, Berlin, 10178, Germany"
          },
          {
            "name":"ALEX, Panoramastr. 1a, Berlin, 10178, Germany"
          },
          {
            "name":"Starbucks, Panoramastr. 1A, Berlin, 10178, Germany"
          },
          {
            "name":"Einstein Kaffee, Alexanderstr. 13, Berlin, 10178, Germany"
          },
          {
            "name":"Café-Haus Koch Berlin, Karl-Liebknecht-Str. 7, Berlin, 10178, Germany"
          },
          {
            "name":"Gregory's, Gontardstr. 10, Berlin, 10178, Germany"
          },
          {
            "name":"Starbucks, Dircksenstr. 2, Berlin, 10178, Germany"
          }
        ]
      },
      {
        "postcode":"10179",
        "coffee_shops": [
          {
            "name":"Starbucks, Grunerstr. 20, Berlin, 10179, Germany"
          }
        ]
      }
    ]
  }
  ```
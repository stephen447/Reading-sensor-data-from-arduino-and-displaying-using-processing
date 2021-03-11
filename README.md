ReadMe
This project will enable you to connect your Arduino (Arduino Nano IOT33) to your computer and send values recorded from a sensor (in this case DHT 22 temperature and humidity sensor) to a csv file stored on your local computer. The values will also be plotted against time using Processing.

I will be using
•	Arduino Nano 33 IOT
•	DHT 22 temperature and humidity sensor
•	Processing


1.	Wire up the Arduino , as seen in image below.
2.	Connect the Arduino to your computer via the serial port. Make sure the correct port is selected in the tools menu bar. Load in the Arduino sketch, upload it to the Arduino and compile it.
3.	Open the serial monitor to confirm the temperature and humidity values are being read.
4.	Load the processing file in processing and run the file. A window should appear with 2 graphs, of temperature versus time and humidity versus time. A csv file will created in the processing project director called temp.csv. This will contain a table with the time and the corresponding temperature and humidity values in degrees celcius and per cent respectivly.





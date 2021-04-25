Read me
This project will enable you to 
•	Send the temperature and relative humidity values from the sensor to a computer using an Arduino Nano IOT 33.
•	Retrieve local weather information using the MET Eireann API.
•	Graph the measured and local temperature and relative humidity using the application Processing in real time
•	Store the measured and retrieved temperature and relative humidity values in a CSV file permanently

The following software and hardware is needed for this project
•	Arduino Nano 33 IOT
•	Arduino IDE (Version 1.8.12)
•	DHT 22 temperature and humidity sensor  
•	Processing (Version: 3.5.4)
•	USB to Mini USB cable
Running the project
1.	Connect the DHT 22 sensor to the Arduino using digital pin 2, the 5 volts power supply and either one of the ground pins on the Arduino.
2.	Connect the Arduino to your computer via the serial port.
3.	Open the Arduino IDE application on the computer. Make sure the correct port is selected in the tools menu bar. Load in the Arduino sketch under File - Open, upload it to the Arduino and compile it.
4.	Open the serial monitor in the tools bar to confirm the temperature and humidity values are being read correctly.
5.	Load the processing file in processing. The users geo co-ordinates must be entered into the URL on line 125. The file can then be run. A window should appear with 2 graphs, of temperature versus time and humidity versus time. A csv file will created in the processing project directory in the format “year;month;day-hour/minute/seconds”.csv. This will contain a table with the time and the corresponding measured temperature , measured relative humidity, exterior temperature and exterior relative humidity values in degrees Celsius and per cent respectively.

Copyright <2021> <Stephen Byrne>
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.








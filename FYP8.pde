//Libraries for different functions 8
import processing.serial.*;


Serial myPort;  // Create object from Serial class
String val;     // Humidity data received from serial port
String val1; //// Temperature data received from serial port
float valf = 0;// val value in float format (humidity)
float valf1 = 0; //val value in float format (temperature)
float lastval = 1; //Last humidity value stored
float lastval1 = 1; //last temperature value stored
int flag = 0; // flag for sorting humidty and temperature values when being read in


float[] humidityarray = new float[100]; // array for storing humidity values
float[] temparray = new float[100]; //array for storing temperature values

int i = 0;
void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
    
}


void draw()
{
 
  // text colour, font, 


  //Reading in values, storing and displaying them
  if ( myPort.available() > 0) 
  {  
    if ( flag == 0) 
    {
      lastval = valf; // store current value of humidity as the last value before new value read in 
      val = myPort.readStringUntil('\n'); //read in humidity value
      valf = float(val); // convery humidty value from string to float

      humidityarray[i] = valf; //store value read in in humidity array
      flag = 1; // set flad so temperature value can be read in
      //Displaying humidity value in real time
      text("Humidity:",(3*width)/4,30);
      text(valf,(3*width)/4+100,30);
      text("Humidity per centage versus Time",(3*width)/4,50);
      
     }
    
    if ( flag == 1) 
    {
      lastval1 = valf1; // store current value of temperature as the last value before new value read in 
      val1 = myPort.readStringUntil('\n'); //read in temperature value
      valf1 = float(val1); //convert value to a float
      
      
      temparray[i] = valf1;// store value in array
      flag = 0; // change flag to read in temperature next
      
      
     } 
  } 
}

//Libraries for different functions 8
import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;     // Humidity data received from serial port

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
    
}


void draw()
{
  //Reading in values, storing and displaying them
  if ( myPort.available() > 0) 
  {  
    {
     val = myPort.readStringUntil('\n'); //read in humidity value
      println(val);
    }
  } 
}

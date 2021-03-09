//Libraries for different functions 10
import processing.serial.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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
int[] xarray = new int[100]; // integer values for x axis

int i = 0; // index for storing values in arrays
int n = 0; // index for going through arrays for graph
int xmin; // minimum x value for graph
int tempmin; // minimum temp value for graph
int hummin; // minimum humidty value for graph
int xmax; // maximum x value for graph
int tempmax; // maximum temperature value for graph
int hummax; //maximum humidity value for graph
PFont f;//font variable
PrintWriter output; // csv file for storing humidity values


void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  textAlign(CENTER); // a;igns text to center
  size(900, 700); // size of output window
  //Assigning different values for min and max values of parameters
  xmin = 0;
  tempmin = 0;
  hummin = 0;
  xmax = 100;
  tempmax = 30;
  hummax = 100;
  
  f = createFont("Arial",16,true); //Assigning font, size
  output = createWriter("temp.csv"); // creating csv file
  d = day();// retrieving current date
  m = month(); // retrieving current month
  y = year(); // retrieving current year
  
  output.print("Date" + ","); //Printing date to top of csv file
  output.println(y + "-" + m + "-" + d);//Printing date to top of csv file
  output.print("Humidity" + ","); // Write the coordinate to the file
  output.println("Temperature" + ","); // Write the coordinate to the file 
  output.flush(); // Writes the remaining data to the file
  
}


void draw()
{
 
  // text colour, font, 
  stroke(175);
  textFont(f);       
  fill(40);
  
  //Axis for graphs
  line(30, 100, 30, height-30); //x axis 
  line((width/2)+15, 100, (width/2)+15, height-30);
  line(30, height-30, (width/2)-15, height-30);
  line((width/2)+15, height-30, width-15, height-30);
  
  //Graph labels
  text("30", 15, 100);
  text("0", 15, height-30);
  text("15", 15, 385);
  text("100", (width/2), 100);
  text("0", (width/2), height-30);
  text("50", (width/2), 385);

  //Reading in values, storing and displaying them
  if ( myPort.available() > 0) 
  {  
    if ( flag == 0) 
    {
      lastval = valf; // store current value of humidity as the last value before new value read in 
      val = myPort.readStringUntil('\n'); //read in humidity value
      valf = float(val); // convery humidty value from string to float
      if(lastval != valf || lastval1 != valf1)// if the humidty or temperature value has change wipe the screen for new vaues to be written
      {
        background(255);
      }

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
      
      //Displaying temperature value in real time
      text("Temperature:",width/4,30);
      text(valf1,width/4+100,30);
      text("Temperature in degrees versus Time",(width)/4,50);
      text("Date: " + y + "-" + m + "-" + d, (width)/2,80);
      
      xarray[i] = i; //store value in for x axis
      i++; // increment counter
      
     }
     
             
    
     output.print(valf + ","); // Write the coordinate to the file
     output.println(valf1 + ","); // Write the coordinate to the file 
     output.flush(); // Writes the remaining data to the file
    
    for(n=0; n<i; n++)
    {
    float xpos1 = map(xarray[n], xmin, xmax, 30, (width/2)-15);
    float xpos2 = map(xarray[n], xmin, xmax, (width/2)+15, width-30);
    float humy = map(100-humidityarray[n], hummin, hummax, 100, height-30);
    float tempy = map(30-temparray[n], tempmin, tempmax, 100, height-30);
    
   
    noStroke();
    ellipse(xpos1,tempy,4,4);
    ellipse(xpos2,humy,4,4);
    
    }
  } 
}

//Libraries for different functions
import processing.serial.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

Serial myPort;  // Create object from Serial class
String val;     // Humidity data received from serial port
String val1; //// Temperature data received from serial port
float valf = 0;// val value in float format (humidity)
float valf1 = 0; //val value in float format (temperature)
int flag = 0; // flag for sorting humidty and temperature values when being read in
int day, month, year; // integer values for date, month and year
int second, hour, minute; // X axis label
int second1, minute1, hour1; //Y axis label
int timeflag = 0;
Timestamp timestamp_last; // Timestamp for comparing each time stamp
XML xml;
String xmlstring;

float[] humidityarray = new float[10800]; // array for storing humidity values(30 min)
float[] temparray = new float[10800]; //array for storing temperature values(30 min)
int[] xarray = new int[10800]; // integer values for x axis (1800)
float[] exttemparray = new float[10800];

int i = 0; // index for storing values in arrays
int n = 0; // index for going through arrays for graph
int xmin; // minimum x value for graph
int tempmin; // minimum temp value for graph
int hummin; // minimum humidty value for graph
int xmax; // maximum x value for graph
int tempmax; // maximum temperature value for graph
int hummax; //maximum humidity value for graph
PFont f, f1;//font variable
PrintWriter output; // csv file for storing humidity values




void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  String portName = Serial.list()[3]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  textAlign(CENTER); // aligns text to center
  size(900, 700); // size of output window
  
  //Assigning different values for min and max values of parameters
  xmin = 0;
  tempmin = 0;
  hummin = 0;
  xmax = 60;
  tempmax = 30;
  hummax = 100;
  
  f = createFont("AvenirNext-Regular",12,true); //Assigning font, size
  //output = createWriter("temp.csv"); // creating csv file
  day = day();// retrieving current date
  month = month(); // retrieving current month
  year = year(); // retrieving current year
  second = second();  // Values from 0 - 59
  minute = minute();  // Values from 0 - 59
  hour = hour(); 
  output = createWriter(year+";"+month+";"+day+"-"+hour+":"+minute+":"+second+".csv"); // creating csv file
  
 
  output.print("Date" + ","); //Printing date to top of csv file
  output.println(year + "-" + month + "-" + day);//Printing date to top of csv file
  output.print("Time" + ","); // Write the coordinate to the file
  output.print("Humidity" + ","); // Write the coordinate to the file
  output.println("Temperature"); // Write the coordinate to the file 
  output.flush(); // Writes the remaining data to the file
  
}


void draw()
{
  
  Timestamp timestamp = new Timestamp(System.currentTimeMillis()); // get current time and store it in timestamp
  SimpleDateFormat sdf = new SimpleDateFormat( "HH:mm:ss" ); // creating format for date according to ISO standards
 
  // text colour, font, 
  stroke(175);
  textFont(f);       
  fill(40);
  
  //Axis for graphs
  line(30, 100, 30, height-30); //x axis temp
  line((width/2)+15, 100, (width/2)+15, height-30); //x axis hum
  line(30, height-30, (width/2)-15, height-30);// y axis temp
  line((width/2)+15, height-30, width-15, height-30); // y axis hum
  
  //Graph labels
  text("30", 15, 100);
  text("0", 15, height-30);
  text("15", 15, 385);
  text("100", (width/2), 100);
  text("0", (width/2), height-30);
  text("50", (width/2), 385);
  text("Time(Hours, minutes, seconds)", width/4, 690);
  text("Time(Hours, minutes, seconds)", (3*width)/4, 690);
  
  // Rotating text of Humidity y axis label
  pushMatrix();
  translate(450, 300);
  rotate(PI/2);
  text("Humidity (per cent)", 0, 0);
  popMatrix();
  
  // Rotating text of Temperature y axis label
  pushMatrix();
  translate(10, 250);
  rotate(PI/2);
  text("Temperature (Degrees Celcius)", 0, 0);
  popMatrix();
  
  //exterior temperature using MET Eireann API
  xml = loadXML("http://metwdb-openaccess.ichec.ie/metno-wdb2ts/locationforecast?lat=53.44;long=-6.18;");
  xmlstring = xml.format(0);
  int start = xmlstring.indexOf("temperature" ) + 43;
  int end        = xmlstring.indexOf(">", start);      // STEP 2
  String exttemp  = xmlstring.substring(start, end);    // STEP 3
  float exttempf   = int(exttemp);  // STEP 4
  exttemparray[i] = exttempf;
  //int start1 = s.indexOf("<humidity" ) + 32;
  //int end1        = s.indexOf(">", start1);      // STEP 2
  //String apples1  = s.substring(start1, end1);    // STEP 3
  //float apple_no1   = int(apples1); 
  
  //Reading in values, storing and displaying them
  if ( myPort.available() > 0) 
  {  
    
    if(i == 0)
    {
        //second = second();  // Values from 0 - 59
        //minute = minute();  // Values from 0 - 59
        //hour = hour();    // Values from 0 - 23
        second1 = second;
        hour1 = hour;
        // Finding the end value for x axis of both graphs
        if(minute == 59)
        {
          minute1 = 00;
          if (hour == 23)
          {
            hour1 = 00;
          }
          else
          {
            hour1 = hour+1;
          }
        }
        else
        {
          minute1 = minute+1;
        }
    }
    
    if ( flag == 0) 
    {
       
      val = myPort.readStringUntil('\n'); //read in humidity value
      valf = float(val); // convery humidty value from string to float
      if(timestamp!= timestamp_last)// if the time value has changed wipe the screen for new vaues to be written
      {
        background(255);
      }
      timestamp_last = timestamp;// save current time timestamp as the last timestamp for the next round

      humidityarray[i] = valf; //store value read in in humidity array
      flag = 1; // set flag to 1, so temperature value can be read in
      
      text("Humidity: " + valf,(3*width)/4,30); //Displaying humidity value in real time
      text("Humidity per centage versus Time",(3*width)/4,50); //
      text(hour+":"+minute+":"+second, 30, 695);
      text(hour+":"+minute+":"+second, (width/2) + 30, 695);
      text(hour1+":"+minute1+":"+second1, (width/2) - 30, 695);
      text(hour1+":"+minute1+":"+second1, (width) - 30, 695);
      
     }
    
    if ( flag == 1) 
    {
      val1 = myPort.readStringUntil('\n'); //read in temperature value
      valf1 = float(val1); //convert value to a float
      temparray[i] = valf1;// store value in array
      flag = 0; // change flag to read in temperature next
      
      //Displaying temperature value in real time
      text("Temperature: " + valf1,(width)/4,30);
      text("Temperature in degrees versus Time",(width)/4,50);

      xarray[i] = i; //store value in for x axis
      i++; // increment counter
      
     }
     
     output.print(sdf.format(timestamp)+",");
     output.print(valf + ","); // Write the coordinate to the file
     output.print(valf1 + ","); // Write the coordinate to the file 
     output.print(exttemp +",");
     output.flush(); // Writes the remaining data to the file
     
    text("Date: " + year + "-" + month + "-" + day + "    Time: " + sdf.format(timestamp), (width)/2,80);
    text("Exterior temperature"+exttempf, (width/2), 50);
    
    if(i>=xmax)
    {
      xmax = xmax+60;// scaling the graphs
      //Adjusting the axis values
      if(minute1 == 59)
        {
          minute1 = 00;
          if (hour1 == 23)
          {
            hour1 = 00;
          }
          else
          {
            hour1 = hour+1;
          }
        }
        else
        {
          minute1 = minute1+1;
        }
    }
    
    for(n=0; n<i; n++)
    {
    float xpos1 = map(xarray[n], xmin, xmax, 30, (width/2)-15);// temperature x values
    float xpos2 = map(xarray[n], xmin, xmax, (width/2)+15, width-30);// humidity x values
    float humy = map(100-humidityarray[n], hummin, hummax, 100, height-30); //humidity values
    float tempy = map(30-temparray[n], tempmin, tempmax, 100, height-30); // temperature values
    float exttempy = map(30-exttemparray[n], tempmin, tempmax, 100, height-30); // temperature values
    
   
    //noStroke();
    ellipse(xpos1,tempy,2,2); // elipse for temperaure data points
    ellipse(xpos1,exttempy,2,2); // elipse for temperaure data points
    ellipse(xpos2,humy,2,2); //elipse for humidityvdata point

    
    }
  } 
}

# weathersapp
The Weather App's well-thought-out UI and different displays provide a seamless, user-centric experience. 
With an easy-to-use "Login" button, the LoginScreen provides a safe and attractive entry point for users to view their customized weather information. 
With its inviting image and intuitive layout, the GetStarted screen extends a warm welcome to users and signals the start of their exploration. 
With an emphasis on user-centric design, the Welcome page offers an entertaining means for users to personalize their weather preferences. 
With its complete overview and real-time updates, the Home screen showcases the app's dedication to both usefulness and aesthetics. 
It also seamlessly integrates city selection. Finally, the Detail Page improves the user experience by offering comprehensive meteorological information, which showcases the app's commitment to accuracy and a visually pleasing layout. 
All of these screens together highlight the Weather App's dedication to security, usability, and the delight of discovering the ever-changing meteorological landscape.

## Login
A crucial point of entry for your weather app is the LoginScreen, which gives users a safe way to access customized weather details. 
With an intuitive and aesthetically pleasing interface, users may enter their credentials with ease. 
An authentication procedure is initiated by the well-placed "Login" button, which is decorated with the app's secondary color. 
After successfully logging in, users are taken to the visually appealing GetStarted screen, which serves as the starting point for exploring the immersive and educational world of the Weather App. When credentials are invalid, an easy-to-use dialog box guarantees a user-friendly experience by prompting users to correct their inputs. 
This screen represents the app's dedication to security, ease of use, and a fun way to explore the weather.

## GetStarted

The GetStarted screen is your Weather App's warm welcome screen, luring visitors to start exploring the weather. 
The interface entices visitors to click the large "Get Started" button, which marks the beginning of their journey, with an eye-catching graphic that embodies the essence of various weather situations. 
Its user-friendly design promises ease of use and convenience while guaranteeing a smooth and intuitive experience. With a unified and branded design, this introduction screen provides a visually stimulating and educational look into the realm of weather, setting the stage for users to explore the app's capabilities.

## Welcome
The Weather App's Welcome page provides users with an engaging and interactive way to personalize their weather preferences. 
By touching on any place that piques their attention, users may easily customize their weather updates from a dynamic list of cities with customizable options. 
The design increases user engagement with its tasteful use of color and subtle shadows. Users are invited to explore more by the floating action button, an intuitive map icon, which smoothly transitions to the Home screen, which offers a plethora of meteorological information. 
This screen, which offers a user-friendly interface for customized weather tracking, illustrates the app's dedication to user-centric design.

## Home
The Home screen of the Weather App provides a comprehensive weather overview, offering real-time updates for the user's selected location. 
Through a visually appealing and user-friendly interface, users can access key weather details, including current temperature, wind speed, humidity, and a seven-day forecast.
The app seamlessly integrates city selection, allowing users to personalize their weather experience. The design incorporates a vibrant color scheme, intuitive icons, and clear typography, enhancing both functionality and aesthetics. 
Users can delve deeper into the day's details or explore the upcoming week's forecast effortlessly. 
The Home screen epitomizes the app's commitment to delivering precise weather information while maintaining an engaging and visually pleasing user experience.

## DetailPage
The Weather App's Detail Page improves the user experience by offering comprehensive weather data for a particular day. 
This page provides a thorough overview of the temperature, wind speed, humidity, and weather conditions, all of which are important components of the daily forecast. 
Clear fonts and iconography are used in the user-friendly design to provide easy reading and navigation. 
Users are empowered to organize their activities more efficiently based on accurate weather conditions because they can easily get this detailed weather information for any desired day. The app's dedication to providing precise and easy-to-use weather updates along with an aesthetically pleasing and educational interface is reflected in the Detail Page.

## Php-Database
Database Connection Parameters:

$hostname: Specifies the host where the MySQL database is located. In this case, it's set to 'localhost,' meaning the database is hosted on the same server as the PHP script.
$database: Specifies the name of the MySQL database ('mad' in this case) to connect to.
$username: Specifies the MySQL user's username (in this case, 'root').
$password: Specifies the MySQL user's password (an empty string in this case).
PDO Connection:

The try block contains the code responsible for connecting to the MySQL database using PDO.
new PDO("mysql:host=$hostname;dbname=$database", $username, $password): Creates a new PDO instance for MySQL with the specified connection parameters.
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION): Sets PDO to throw exceptions if an error occurs during the execution of a database query.
Error Handling:

The catch block captures any exceptions that may occur during the database connection process.
PDOException $e: Captures and stores the exception object.
echo "Connection failed: " . $e->getMessage();: 
Displays an error message if the connection to the database fails, including details from the exception.

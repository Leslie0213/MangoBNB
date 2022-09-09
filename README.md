#  Mangobnb is a clone of the Airbnb web app. 
MangoBnB incorporates the basic functionabilities of 
an accomodation booking app.



![image](https://user-images.githubusercontent.com/42100507/189228669-09548077-30b7-4384-be5c-2441ea135a96.png)


 ## **How to Use The App**

- First download the code from the repository on your local machine.

- Then check if you have ruby installed on your machine.

    To check the version of ruby installed on your machine run ruby -v

    To upgrade to the most stable version run rvm get stable
    
    To  run the lastest version of ruby as default rvm use ruby --latest --install --default
    
    
- After that create a database locally. We created the database mangobnb and pointed it to the seeds files.

- Run the database to check the data has been entered. We used PostgreSQL and to visualize the database TablePlus.

- Run bundle install. This sould install the necessary gems and any other dependencies.

- Run Ruckup to initialize the server on your machine and run your local host http://localhost:9292



## **These are some of the user stories.**



### Signup


- On the app, users have the facility to create an account by saving their email address and password.

  Once the email adrdress and password are inputted on the form, those details are stored on a database. 
  
- The user once signed is taken to a new screen that confirms the account has been created.
  
  
- If the user wants to create a new account with the same details the user will be prompted with a message that warns the

  person is already registered. Also, if the user tries to log in with an incorrect password or email address the app will check the 
  
  details against the details stored on the database and trigger the error message  
  
  > UserID or Password incorrect Please try again.
  
  
  
  
  
  ![image](https://user-images.githubusercontent.com/42100507/189335836-1439f0ea-e672-479f-8d64-b21c65b7cefc.png)
	




### Login


- The user can log in by clicking on the login button. The login screen doesn't have an extra password confirmation step.

- Once the user is logged in, they are able to view the property listings. 




### Listed Sapces



- The listing is connected to a database which stores all the properties details. 


-  The listed spaces feature a brief description of each place, fee per night and availability.


- Registered users are able to list a new place, write a brief description of the place, input fee per night and the 

  dates the property will be available. The new property details once created are stored on the spaces database.
  
  
### Book Spaces
  
  
- Users have the facility to book spaces and check dates on a calendar.
  
- Users can choose dates from and to and once the booking has been made there is a confirmation message.
	
	
	






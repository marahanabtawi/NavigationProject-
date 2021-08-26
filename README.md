Requirements
Build an app That shows a list of profiles, the user can select a profile to see full details about the user or can swipe to Delete. The App will also have a sectioned photo gallery where the user will be able to a collection of thumbnails and select any one to show the photo in full screen like FB App.
 
 Phase 1:

1-Draw Wire Frames to Represent the app general UI/UX
2-Build Basic App Function with Static Data that includes:
   1.Navigation Controllers
     a)Tab
       1.UserList
       2.Gallery
     b)Stack 
       1.User Details 
   2.List of 3 users showing:
     1.UserName 
     2.Email
   3.User Details showing:
     1.Above details
     2.Full Name
     3.Phone Number
     4.Website
  4.Photo Gallery
    1.Display 5 static Images 
    2.Configure as a grid view 2 in a row


  Phase 2:

 1.Convert app to use dynamic Data using APIs from “https://jsonplaceholder.typicode.com/"
    1)Users API will be using URLSession
    2)Photo API will be using AlamoFire
 2.All models must use Codable
 3.Photo Gallery
    1)Pressing an Image Will show the High res photo in full screen just like and Social media app
    2)Full Screen photo needs to a way to exit the photo 
    3)The Photos must be grouped based on AlbumID
 4.User List 
    1)Implement Swipe to Delte
    2)Support scroll down to search Like iOS Messages App
    3)Must show Company Name For some user on Random Basis 
    4)The cells must adjust their height based on the content
 5.User Details
    1)Show all info from Api
    2)Phone Number must be clickable and opens to phone 
    3)Email must be clickable and opens to new Email
    4)Location Should show a map preview pinpointing the location

/*

rules_version = '2'; // By default
service cloud.firestore { // By default
  match /databases/{database}/documents { // By default
  	
  	match /users/{uid}{ // means collection of users and {uid} is placeholder for matching in below condition
    	allow write: if request.auth != null && request.auth.uid == uid; // This allow to write only to the user who is logged in and only himself
    }
    
    match /users/{uid}{
    	allow read: if request.auth != null; // read to all auth users to see all users
    }
    
    match /chat/{document=**} {  // means collection of chats and {document=**} is special syntax for showing that all this collection documents  
      allow read, create: if  // allow read and can also create if he is authanticated
          request.auth != null;
    }
  }
}
 */



/* Storage Rules:

rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o { // instead of collection we have bucket
    match /{allPaths=**} { // here instead of documents we have paths 
      allow read, create: if request.auth != null;
    }
  }
}
 */
# Installation
Metacello new
        repository: 'github://seandenigris/Monticello-Login:master/repository';
        baseline: 'MonticelloLogin';
        onConflict: [ :ex | ex allow ];
        load.

# Usage
It expects a file named .mcconfig in a user-specifiable folder (set with `MlConfigurationFile folder: aFolder`), in the following format:
[squeaksource]
  user := 'SD'.
  password := 'mypassword'.
[squeaksource3]
  user := 'SeanDeNigris'.
  password = '12345'.
[smalltalkhub]
  user := 'SeanDeNigris'.
  password = 'secret'.

# Disclaimer
As you can see, I show my actual passwords in case you need to access my accounts ;-p

p.s. it is just a utility for my personal convenience, so no warranty! 

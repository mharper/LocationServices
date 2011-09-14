The Locinator
=============

Contributors:

+ Michael Harper (original author)
+ Christopher Sexton (awesome engineer and graphics guy)
+ *Your name could be here!*

Why?
----
This project started as a simple answer to [this question](http://stackoverflow.com/questions/7266700/when-does-an-iphone-application-receive-didchangeauthorizationstatus-delegate-ca/7276490#7276490) on StackOverflow.

I decided to evolve this into a simple "You Are Here" sort of app, except that it would display your coordinates as opposed to your location on a map.  From there it was simply a matter of piling on more and more data until the screen filled up with raw numerical goodness.

Fasten Your Seat Belt
---------------------

![awesome screenshot](http://github.com/mharper/LocationServices/raw/master/Screenshot.png)

Fine Print
----------
Note that this was built with a beta version of Xcode 4.2 against a beta version of iOS 5. It also uses Automatic Reference Counting (ARC), hence the absence of retains and releases. It *should* run on iOS versions all the way back to 4.2, however.

I strongly recommend running this app on the device to experience all the interesting data.  If you run the app in the 4.3 simulator, you get "server did not accept client registration 68" and all zeros for data.  If you run it in the iOS 5 simulator and set the location from Xcode, you can get some small amount of information.  Anyway, the app is significantly funnerer on the device!

Acknowledgments
---------------
Thank you very much to [Christopher Sexton](https://github.com/csexton) of [Codeography](http://www.codeography.com) for moral support as well as the insanely cool app icon!


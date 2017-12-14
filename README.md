# Team Project for MIT 2.78/6.811/HST.420 Assistive Technology
iNotify is a discrete and customizable iOS notification app that allows the user to easily and effectively communicate and seek help while experiencing symptoms of aphasia. The app includes three main communication features, as well as an analytics feature: 
+ __Notify__: Sends pre-customized emails and texts to recipients. Used for instances when one wants to alert others of their current state but does not send the location within the message. 
+ __Get Help__: Sends pre-customized texts with the location to the recipient. Used in instances when the user is seeking more immediate help from the recipient of the message. 
+ __Display__: Show a pre-set message to passerby who may be wondering of the best way to help the individual. 

iNotify is not available on the Apple App Store yet, however users will be able to download it and simulate it on their macOS computer by following the steps below. Note that at the moment of publication, only those registered within the Apple Developer program may download the app to their iOS devices:
1. Download and install XCode from the Mac App Store.
2. Clone the GitHub repository onto your local computer by visiting https://github.com/williamrodz/TeamErica, click on the green “Clone or Download” button on the right side of the screen and do one of the following:
   + Git clone the repository with the provided link
   + Download the project file contents as a ZIP file then unzip it locally.
   + (Recommended) Click on “Open in XCode”. This will clone the project repository to your computer and automatically open the project in XCode
3. Download CocoaPods onto your computer by following these steps:
   + Open terminal, type and execute: sudo gem install cocoapods
   + If there is an error "activesupport requires Ruby version >= 2.xx", then install latest activesupport first by typing the following command in the terminal: sudo gem install activesupport -v 4.2.6
   + After installation, there will be many of messages, scan them and if no error found (typically red), this means cocoapods installation is done.
   + Next, you need to download the Alamofire and MailCore cocoa pods within the directory of your project. Cd to your Xcode project root directory (where your .xcodeproj file resides) in terminal and then execute the following command: pod setup
   + Once done, it will output "Setup Complete", creating and XCode workspace file. 
   + Then in terminal, within the same project directory  type: pod init
   + Then, finally install Alamofire and MailCore into your project by typing in the terminal: pod install
   + Once completed, there will be a message that says "Pod installation complete! There are X dependencies from the Podfile and X total pods installed."
4. Now close your Xcode project and open the newly created .xcworkspace Xcode project file. All future edits should be made by opening this workspace file. The project will not build in the original file.
5. To simulate the app, choose the simulation target at the top left of the XCode screen. We built and simulated the app for the iPhone 6.
6. To run the app on your phone, you must have a registered developer account. To add your developer account, select "Xcode" at the top-left of the menu bar -> Preferences -> Accounts -> Click "+" -> Apple ID and then add your credentials. Then, select the project from the Xcode left menu bar (should have a blue page icon on its left). Under "Signing", change your team to your developer account team. Afterwards, connect your iPhone via USB, and select it as the deployment target in the top-left of the screen. Finally, hit the play button right next to it to build the app on your unlocked device. You may also attempt to build the file wirelessly by: Connect your iPhone to the computer and go to Window → Devices and Simulators → Select your connected device → Check the “Connect via network” box.




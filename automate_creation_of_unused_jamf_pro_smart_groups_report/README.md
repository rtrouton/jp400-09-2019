Automate the creation of a list which displays every computer smart group which is not being used to scope a policy or a macOS configuration profile.

Tools used:

* AutoPkg: [https://github.com/lindegroup/autopkgr](https://github.com/lindegroup/autopkgr)
* JSSImporter: [https://github.com/jssimporter/JSSImporter](https://github.com/jssimporter/JSSImporter)
* Spruce: [https://github.com/jssimporter/Spruce](https://github.com/jssimporter/Spruce)

A. Install AutoPkgr if not already present.

B. Install JSSImporter if not already present.

C. Run the following command to add needed support for JSSImporter on macOS Mojave:

`sudo easy_install pip && pip install -I --user pyopenssl && pip install --user requests`

D. Configure JSSImporter to connect to the Jamf Pro server.

E. Download Spruce if not already available and run it using the following command:

`/path/to/spruce.py --computer_groups --ofile unused_smart_groups.xml`

F. Spruce communicate with the Jamf Pro server via the API and generate a file named `unused_smart_groups.xml`. This is a report in XML format showing which smart groups are not being used for scoping.

[https://gist.github.com/rtrouton/52e541fa440bfb79337c5970e079bc45](https://gist.github.com/rtrouton/52e541fa440bfb79337c5970e079bc45)

Additional tools:

The Scope Report - [https://github.com/zdorow/TheScopeReport](https://github.com/zdorow/TheScopeReport)
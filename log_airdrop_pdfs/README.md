Generate a list of .pdf files that have been received over AirDrop. The search should occur every Friday at 5:00 PM even if the computer cannot contact the Jamf Pro server.

Tools used:

* BBEdit: [https://www.barebones.com/products/bbedit/](https://www.barebones.com/products/bbedit/)
* Launched: [http://launched.zerowidth.com](http://launched.zerowidth.com)

A. Create `log_airdrop_pdfs.sh` script which does the following:

1. Uses `mdfind` to identify AirDropped PDFs using the following command: `/usr/bin/mdfind kind:pdf com.apple.AirDrop`

2. Exports list to `/var/log/airdropped_pdfs.log`

[https://gist.github.com/rtrouton/76f021884121bb2d04480609636b603c](https://gist.github.com/rtrouton/76f021884121bb2d04480609636b603c)

B. Create `com.company.airdrop_pdf_check.plist` LaunchDaemon file to run `/Library/Scripts/log_airdrop_pdfs.sh` every Friday at 5:00 PM

[https://gist.github.com/rtrouton/44459024ce1deb0738b9d17de5723240](https://gist.github.com/rtrouton/44459024ce1deb0738b9d17de5723240)

C. Create extension attribute to read contents of `/var/log/airdropped_pdfs.log`

[https://gist.github.com/rtrouton/8729d6fec1d466bd2f0f6d146ee74d2c](https://gist.github.com/rtrouton/8729d6fec1d466bd2f0f6d146ee74d2c)

D. Save `log_airdrop_pdfs.sh` to `/Library/Scripts/log_airdrop_pdfs.sh` and run the following commands with root privileges to make sure it's executable:

`chown root:wheel /Library/Scripts/log_airdrop_pdfs.sh`
`chmod 755 /Library/Scripts/log_airdrop_pdfs.sh`

E. Add extension attribute to Jamf Pro.

F. Save `com.company.airdrop_pdf_check.plist` to `/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist` on test Mac and run the following command with root privileges to make sure it has the correct permissions:

`chown root:wheel /Library/LaunchDaemons/com.company.airdrop_pdf_check.plist`

G. Load `com.company.airdrop_pdf_check` LaunchDaemon on test Mac by running the following commands with root privileges to load it:


`launchctl load /Library/LaunchDaemons/com.company.airdrop_pdf_check.plist`

H. Verify that LaunchDaemon and script are working as expected.

I. Create installation script for script and LaunchDaemon.

[https://gist.github.com/rtrouton/79e4112ac51fa57a4b6201b0cd1a3985](https://gist.github.com/rtrouton/79e4112ac51fa57a4b6201b0cd1a3985)

J. Upload installation script to Jamf Pro for deployment.

Useful links:

* [https://hcsonline.com/support/blog/entry/airdrop-logging-on-a-mac-computer](https://hcsonline.com/support/blog/entry/airdrop-logging-on-a-mac-computer)
* [https://ss64.com/osx/mdfind.html](https://ss64.com/osx/mdfind.html)

#!/bin/bash
 
# If any previous instances of the airdrop_pdf_check LaunchDaemon and 
# log_airdrop_pdfs script exist, unload the LaunchDaemon and remove 
# the LaunchDaemon and script files.
 
if [[ -f "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist" ]]; then
   /bin/launchctl unload "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist"
   /bin/rm "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist"
fi
 
if [[ -f "/Library/Scripts/log_airdrop_pdfs.sh" ]]; then
   /bin/rm "/Library/Scripts/log_airdrop_pdfs.sh"
fi
 
# Create the airdrop_pdf_check LaunchDaemon by using cat input redirection
# to write the XML contained below to a new file.
#
# The LaunchDaemon will run every Friday at 5:00 PM.
 
/bin/cat > "/tmp/com.company.airdrop_pdf_check.plist" << 'AIRDROP_LOGGING_LAUNCHDAEMON'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.company.airdrop_pdf_check</string>
	<key>ProgramArguments</key>
	<array>
		<string>sh</string>
		<string>-c</string>
		<string>/Library/Scripts/log_airdrop_pdfs.sh</string>
	</array>
	<key>StartCalendarInterval</key>
	<dict>
		<key>Hour</key>
		<integer>17</integer>
		<key>Minute</key>
		<integer>0</integer>
		<key>Weekday</key>
		<integer>5</integer>
	</dict>
</dict>
</plist>
AIRDROP_LOGGING_LAUNCHDAEMON
 
# Create the log_airdrop_pdfs script by using cat input redirection
# to write the shell script contained below to a new file.
 
/bin/cat > "/tmp/log_airdrop_pdfs.sh" << 'AIRDROP_LOGGING_SCRIPT'
#!/bin/bash

output_file=/var/log/airdropped_pdfs.log

# Create output file if it doesn't exist.

if [[ ! -f "$output_file" ]]; then
    touch "$output_file"
fi

# Look for PDF files which have been received via AirDrop
# Links:
# https://hcsonline.com/support/blog/entry/airdrop-logging-on-a-mac-computer
# https://ss64.com/osx/mdfind.html

/usr/bin/mdfind kind:pdf com.apple.AirDrop > $output_file
AIRDROP_LOGGING_SCRIPT
 
# Once the LaunchDaemon file has been created, fix the permissions
# so that the file is owned by root:wheel and set to not be executable
# After the permissions have been updated, move the LaunchDaemon into 
# place in /Library/LaunchDaemons.
 
/usr/sbin/chown root:wheel "/tmp/com.company.airdrop_pdf_check.plist"
/bin/chmod 755 "/tmp/com.company.airdrop_pdf_check.plist"
/bin/chmod a-x "/tmp/com.company.airdrop_pdf_check.plist"
/bin/mv "/tmp/com.company.airdrop_pdf_check.plist" "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist"
 
# Once the script file has been created, fix the permissions
# so that the file is owned by root:wheel and set to be executable
# After the permissions have been updated, move the script into the
# place that it will be executed from.
 
/usr/sbin/chown root:wheel "/tmp/log_airdrop_pdfs.sh"
/bin/chmod 755 "/tmp/log_airdrop_pdfs.sh"
/bin/chmod a+x "/tmp/log_airdrop_pdfs.sh"
/bin/mv "/tmp/log_airdrop_pdfs.sh" "/Library/Scripts/log_airdrop_pdfs.sh"
 
# After the LaunchDaemon and script are in place with proper permissions, load the LaunchDaemon.

if [[ -f "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist" ]]; then 
   /bin/launchctl load -w "/Library/LaunchDaemons/com.company.airdrop_pdf_check.plist" 
fi 

exit 0
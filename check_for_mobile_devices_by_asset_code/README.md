Add policy to Self Service which does the following:

1. Requests asset code for a mobile device from Jamf Pro using the API using encrypted credentials.
2. Checks for all mobile devices that match that asset code (may be more than one.)
3. Displays dialog reporting how many mobile devices matched the asset code.
4. Offers the user an option of generating a report on all devices that matched the asset code.

Tools used:

* BBEdit: [https://www.barebones.com/products/bbedit/](https://www.barebones.com/products/bbedit/)

A. Install BBEdit if not already present.

B. Write a script to accomplish the goals described above:

[https://gist.github.com/rtrouton/bf99c7b1b1d66e48420bf31e3dae28f0](https://gist.github.com/rtrouton/bf99c7b1b1d66e48420bf31e3dae28f0)

For more information on using encrypted credentials in scripts, please see the link below:

[https://github.com/jamf/Encrypted-Script-Parameters](https://github.com/jamf/Encrypted-Script-Parameters)

C. Upload script to Jamf Pro.

D. Create Self Service policy to run the script.

E. Verify that both the Self Service policy and script are working correctly.
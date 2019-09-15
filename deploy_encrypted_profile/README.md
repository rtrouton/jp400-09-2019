Install a configuration profile that includes an encrypted Wi-Fi payload on designated clients

Tools used:

* Profile Creator: [https://github.com/ProfileCreator/ProfileCreator](https://github.com/ProfileCreator/ProfileCreator)
* openssl
* mdmclient
* make-profile-pkg: [https://github.com/timsutton/make-profile-pkg](https://github.com/timsutton/make-profile-pkg)

A. Install Profile Creator if not already present.

B. Install make-profile-pkg if not already present.

C. Create self-signed root CA TLS certificate for encryption by using `openssl` and the following commands:

* `openssl genrsa -des3 -passout pass:x -out server.pass.key 2048`
* `openssl rsa -passin pass:x -in server.pass.key -out server.key`
* `rm server.pass.key`
* `openssl req -new -key server.key -out server.csr`
* `openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt`

Results in three files:

* server.crt (public key)
* server.csr (CSR)
* server.key (private key)

server.crt's subject: `subject=/C=US/ST=MD/L=Middletown/O=Company Name/OU=IT/CN=wifi.company.com`

Common Name: `wifi.company.com`

D. Combined `server.crt` (public key) and `server.key` (private key) into one file named `filename.txt`

E. Ran the following command to create `filename.p12` file containing both public and private key:

`openssl pkcs12 -export -in filename.txt -out filename.p12`

Export passcode: `pass123`

F. Built system-level profile with embedded .p12 file containing both private and public key. Profile is named `wifi.company.com Root CA.mobileconfig`:

[https://gist.github.com/rtrouton/7db0980a5ec54613214815fb6357c0ea](https://gist.github.com/rtrouton/7db0980a5ec54613214815fb6357c0ea)

This profile will install into the System keychain and provide a chain of trust and decipherment key for the encrypted profile.

G. Installed `wifi.company.com Root CA` profile onto build Mac. Once installed, it was available for encrypting a WiFi profile.

H. Built a WiFi profile using Profile Creator. Profile is named `Company WiFi.mobileconfig`:

[https://gist.github.com/rtrouton/9b1755d40835c4a7bcb9500726ce93b6](https://gist.github.com/rtrouton/9b1755d40835c4a7bcb9500726ce93b6)

I. Encrypted payload of the the WiFi profile using the `wifi.company.com` certificate installed into the System keychain by running the following command:

`/usr/libexec/mdmclient encrypt "wifi.company.com" "$HOME/Desktop/Company WiFi.mobileconfig"`

Encrypted profile named `Company WiFi.encrypted.mobileconfig`

[https://gist.github.com/rtrouton/2ddb31ba5e75bb94f93070bcd47e3f5c](https://gist.github.com/rtrouton/2ddb31ba5e75bb94f93070bcd47e3f5c)

J. Upload the the `wifi.company.com Root CA` profile to Jamf Pro

K. Deploy the `wifi.company.com Root CA` profile to all appropriate clients.

L. Once the `wifi.company.com Root CA` profile is deployed, build an installer package for deploying the encrypted WiFi profile using `make-profile-pkg`. This package can be generated using the following command:

`/path/to/make_profile_pkg.py --pkg-prefix com.company "/path/to/Company WiFi.mobileconfig"`

**Note**: The reason that an installer package must be used to install the encrypted WiFi profile is that uploading the encrypted WiFi profile to Jamf Pro will fail. The reason it will fail is that Jamf Pro is not able to read the encrypted parts of the profile.

M. Upload the installer package to Jamf Pro

N. Deploy the installer package to all appropriate clients to install the encrypted WiFi profile.

Note:

Apple's documentation on encrypted payloads is very sparse and consists of the following (from [https://developer.apple.com/documentation/devicemanagement/using_configuration_profiles](https://developer.apple.com/documentation/devicemanagement/using_configuration_profiles):

------

Encrypt and Sign a Profile

Both iOS and macOS support using encryption to protect the contents of profiles from unauthorized access. The encrypted profile can only be decrypted using a private key previously installed on a device. To encrypt a profile:

1. Remove the PayloadContent array and serialize it as a property list. Note that the top-level object in this property list is an array, not a dictionary.
2. CMS-encrypt the serialized property list as enveloped data.
3. Serialize the encrypted data in DER (Distinguished Encoding Rules) format.
4. Set the serialized data as the value of as a data property list item in the profile, using the EncryptedPayloadContent key.  
Signing a profile guarantees data integrity. To sign a profile, place the XML property list in a DER-encoded, CMS Signed Data structure.

------

Example commands for CMS encryption of the property list are not provided in Apple's documentation, but it is possible to use `/usr/libexec/mdmclient`:

[https://mosen.github.io/profiledocs/troubleshooting/mdmclient.html#encrypt](https://mosen.github.io/profiledocs/troubleshooting/mdmclient.html#encrypt)

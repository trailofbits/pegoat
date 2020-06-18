# sign.ps1: create a self-signed cert and use it to sign the specified file
# adapted from: https://stackoverflow.com/a/51443366/3354209

$cert = New-SelfSignedCertificate `
  -DnsName "contact@trailofbits.com" `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

Export-Certificate `
  -Cert $cert `
  -FilePath code_signing.crt

Import-Certificate `
  -FilePath .\code_signing.crt `
  -Cert Cert:\LocalMachine\TrustedPublisher

Import-Certificate `
  -FilePath .\code_signing.crt `
  -Cert Cert:\LocalMachine\Root

Set-AuthenticodeSignature `
  $args[0] `
  -Certificate $cert

# sign.ps1: create a self-signed cert and use it to sign the specified file
# adapted from: https://stackoverflow.com/a/51443366/3354209

New-SelfSignedCertificate `
  -DnsName "contact@trailofbits.com" `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

Export-Certificate `
  -Cert (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0] `
  -FilePath code_signing.crt

Import-Certificate `
  -FilePath .\code_signing.crt `
  -Cert Cert:\CurrentUser\TrustedPublisher

Import-Certificate `
  -FilePath .\code_signing.crt `
  -Cert Cert:\CurrentUser\Root

Set-AuthenticodeSignature `
  $args[0] `
  -Certificate (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)

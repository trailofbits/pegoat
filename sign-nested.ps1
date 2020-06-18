$cert1 = New-SelfSignedCertificate `
  -Subject "A SHA-1 cert" `
  -DnsName "ToB-SHA1", "trailofbits.com" `
  -HashAlgorithm SHA1 `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

$cert2 = New-SelfSignedCertificate `
  -Subject "A SHA-256 cert" `
  -DnsName "ToB-SHA256", "trailofbits.com" `
  -HashAlgorithm SHA256 `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

Export-Certificate `
  -Cert $cert1 `
  -FilePath code_signing_1.crt

Export-Certificate `
  -Cert $cert2 `
  -FilePath code_signing_2.crt

signtool.exe sign `
  /f code_signing_1.crt `
  $args[0]

signtool.exe sign `
  /f code_signing_2.crt `
  /as `
  $args[0]

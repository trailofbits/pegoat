New-SelfSignedCertificate `
  -DnsName "contact@trailofbits.com" `
  -HashAlgorithm SHA1 `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

New-SelfSignedCertificate `
  -DnsName "contact@trailofbits.com" `
  -HashAlgorithm SHA256 `
  -Type CodeSigning `
  -CertStoreLocation `
  cert:\CurrentUser\My

Export-Certificate `
  -Cert (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0] `
  -FilePath code_signing_1.crt

Export-Certificate `
  -Cert (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[1] `
  -FilePath code_signing_2.crt

signtool.exe sign `
  /f code_signing_1.crt `
  $args[0]

signtool.exe sign `
  /f code_signing_2.crt `
  /as `
  $args[0]

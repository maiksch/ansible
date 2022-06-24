TMP_PATH=/tmp/localhost-dev-cert
sudo mkdir -p $TMP_PATH

cleanup() {
	sudo rm -r $TMP_PATH
}

KEYFILE=$TMP_PATH/dotnet-devcert.key
CRTFILE=$TMP_PATH/dotnet-devcert.crt
PFXFILE=$TMP_PATH/dotnet-devcert.pfx

CONF_PATH=$TMP_PATH/localhost.conf
cat >> $CONF_PATH <<EOF
[req]
prompt                  = no
default_bits            = 2048
distinguished_name      = subject
req_extensions          = req_ext
x509_extensions         = x509_ext

[ subject ]
commonName              = localhost

[req_ext]
basicConstraints        = critical, CA:true
subjectAltName          = @alt_names

[x509_ext]
basicConstraints        = critical, CA:true
keyUsage                = critical, keyCertSign, cRLSign, digitalSignature,keyEncipherment
extendedKeyUsage        = critical, serverAuth
subjectAltName          = critical, @alt_names
1.3.6.1.4.1.311.84.1.1  = ASN1:UTF8String:ASP.NET Core HTTPS development certificate # Needed to get it imported by dotnet dev-certs

[alt_names]
DNS.1                   = localhost
EOF

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEYFILE -out $CRTFILE -config $CONF_PATH --passout pass:
openssl pkcs12 -export -out $PFXFILE -inkey $KEYFILE -in $CRTFILE --passout pass:

dotnet dev-certs https --clean --import $PFXFILE -p ""

sudo cp $CRTFILE "/etc/pki/ca-trust/source/anchors/"
sudo update-ca-trust

cleanup

dotnet dev-certs https -ep localhost.crt --format PEM

# Trust Edge/Chrome
echo "Trust Edge/Chrome"
certutil -d sql:$HOME/.pki/nssdb -A -t "P,," -n localhost -i ./localhost.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "C,," -n localhost -i ./localhost.crt

# Trust dotnet-to-dotnet (.pem extension is important here)
echo "Trust dotnet-to-dotnet"
sudo cp localhost.crt /etc/pki/tls/certs/aspnetcore-localhost-https.pem
sudo update-ca-trust

# Cleanup
rm localhost.crt

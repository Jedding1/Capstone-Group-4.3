cd /home/$LOGNAME/mobsfscan_auto/IPA
# Reads name of file
echo -n "what is the app name? "
read appname

#hashes file with md5sum, an saves just the hash to varable
hash=$(md5sum $appname)
hash1=$(echo ${hash:0:32})

# runs upload to mobsf website, with info from inputs
echo "uploading..."
curl -F "file=@/home/$LOGNAME/mobsfscan_auto/IPA/$appname" http://localhost:8000/api/v1/upload -H "Authorization:ccf4c2b748de1c70f3330da187cbfacfce1373c44729b3f944832d21a199daa4"

#runs scan on mobsfwebsite, NEEDS HASH
echo "scanning..."
curl -X POST --url http://localhost:8000/api/v1/scan --data "scan_type=ipa&file_name=$appname&hash=$hash1" -H "Authorization:ccf4c2b748de1c70f3330da187cbfacfce1373c44729b3f944832d21a199daa4"

# create report, NEEDS HASH
echo "generating report...."
curl -X POST --url http://localhost:8000/api/v1/report_json --data "hash=$hash1" -H "Authorization:ccf4c2b748de1c70f3330da187cbfacfce1373c44729b3f944832d21a199daa4"

#wgets file and renames it to the md5 hash of app.
echo "downloading report..."
wget http://0.0.0.0:8000/pdf/?md5=$hash1
mv "index.html?md5=$hash1" $hash1.pdf

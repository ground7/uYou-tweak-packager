setup-azule

wget -qO- https://github.com/MiRO92/uYou-for-YouTube \
| grep -o "https://miro92.com/repo/.*.zip" \
| xargs wget -q -P /debs
unzip /debs/*.zip -d /debs
rm /debs/*.zip

curl -s https://api.github.com/repos/Luewii/iSponsorBlock/releases/latest \
| grep -o "https://github.com/Luewii/iSponsorBlock/releases/download/.*deb" \
| xargs wget -q -P /debs

wget -qO- https://www.ios-repo-updates.com/repository/poomsmart/package/com.ps.youpip/ \
| grep -o -m 1 https://poomsmart.github.io/repo/.*.deb \
| xargs wget -q -P /debs

azule -i /debs/*.ipa -f /debs/*sponsor*.deb /debs/*pip*.deb -o /debs -n uYou+
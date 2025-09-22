REPO=0x234256/_YTLitePlus
NAME=YTLitePlus.ipa

set -e

fastlane ios adhoc

BUILD=$(date +%s) 
NEW_VERSION=19.${BUILD}

./ota.sh $NEW_VERSION

echo $NEW_VERSION > version

git add  public/manifest.plist
git add version
git commit -m "new Version ${NEW_VERSION}"
git tag -s -a ${NEW_VERSION} -m "v${NEW_VERSION}"

git push origin HEAD --tags
gh release create ${NEW_VERSION} ${NAME} --notes "v${NEW_VERSION}"


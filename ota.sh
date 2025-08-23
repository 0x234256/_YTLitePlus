source .env
set -e

NAME_IPA_PACH=orange.ipa
URL_DOWNLOAD="${URL_IPA}/${NAME_IPA_PACH}"

echo "Start Dowload"
curl "$URL_DOWNLOAD" -o $NAME_IPA_PACH  > /dev/null 2>&1
echo "End Downalod"

echo "Start update profiles"
fastlane devices  > /dev/null 2>&1
echo "End update profiles"

echo "Start resing App"
fastlane adhoc > /dev/null 2>&1
echo "End resing App"

mkdir public
cp $NAME_IPA_PACH public/orange.ipa

echo "Gen Ota-site"
cat > public/index.html <<EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Orange</title>
    <meta http-equiv="refresh" content="0; URL='itms-services://?action=download-manifest&url=${URL_IPA}/manifest.plist'" />
    <style>
body {
  background-color: Canvas;
  color: CanvasText;
  color-scheme: light dark;
}
    </style>
  </head>
  <body>
  </body>
</html>
EOF

echo "manifest.plist..."
cat > public/manifest.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>items</key>
    <array>
        <dict>
            <key>assets</key>
            <array>
                <dict>
                    <key>kind</key>
                    <string>software-package</string>
                    <key>url</key>
                    <string>${URL_DOWNLOAD}</string>
                </dict>
            </array>
            <key>metadata</key>
            <dict>
                <key>bundle-identifier</key>
                <string>${BUNDLE_ID}</string>
                <key>bundle-version</key>
                <string>2.7.2</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>Orange</string>
                <key>subtitle</key>
                <string>Aplicativo Orange</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF


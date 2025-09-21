source .env
set -e

VERSION=$1

DOMAIN=
URL_DOWNLOAD=https://github.com/0x234256/_YTLitePlus/releases/download/${VERSION}/YTLitePlus.ipa
BUNDLE_ID=com.google.ios.youtube

# echo "Start resing App"
# fastlane adhoc
# echo "End resing App"

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
                <string>19.34.2</string>
                <key>kind</key>
                <string>software</string>
                <key>title</key>
                <string>YoutubePlus</string>
                <key>subtitle</key>
                <string>Aplicativo YoutubePlus</string>
            </dict>
        </dict>
    </array>
</dict>
</plist>
EOF


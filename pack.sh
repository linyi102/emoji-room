export HOME=/c/Users/11580

# 获取版本
androidVersion=$(grep -m1 'version:' pubspec.yaml | awk '{print $2}')
androidVersion="v$androidVersion"
echo "Android版本：$androidVersion"
windowsVerison=$(grep -oP '#define VERSION_AS_STRING "\K[^"]+' windows/runner/Runner.rc)
windowsVerison="v$windowsVerison"
echo "Windows版本：$windowsVerison"

# 输出目录
packRootDir="$HOME/Desktop/EmojiRoom ${androidVersion}"
mkdir -p "$packRootDir"

# Android
apkBuildDir="build/app/outputs/flutter-apk"
cp "$apkBuildDir/app-release.apk" "$packRootDir/EmojiRoom-$androidVersion-android.apk"

# Windows
windowsOriDir="build/windows/runner/Release"
windowsOutputDir="$packRootDir/EmojiRoom $windowsVerison for Windows"
windowsOutputZipPath="$packRootDir/EmojiRoom-$windowsVerison-windows.zip"

cp -r "$windowsOriDir" "$packRootDir"
mv "$packRootDir/Release" "$windowsOutputDir"
7z a -tzip "$windowsOutputZipPath" "$windowsOutputDir"

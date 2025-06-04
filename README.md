### 1. How to update app icon and splash screen ?
Edit `assets_generation/AppTemplate.fig`
    - Export each individual icon assets in `assets_generation/icon`
    - Export each individual splash screen assets in `assets_generation/splash_screen`

Run `sh ./scripts/generate_launcher_icons.sh`
Run `sh ./scripts/generate_splash_screens.sh`

### 2. How to update app links to the app store ? [TODO:]
After registering your app on the play store and app store, you need to update the links in the code
- open `lib/core/texts/app_links.dart`
Replace androidAppStoreUrl with the link to your app on the play store
Replace iosAppStoreUrl with the link to your app on the app store

### How Firebase Remote Config works ?
string variable `min_app_version_ios` is used to check if the app is up to date on the app store
string variable `min_app_version_android` is used to check if the app is up to date on the play store
string variable `remote_url` is used to update the remote url for the app

### How to update url for the app ?
1. Update `env/.env` with the new url
2. Update `remote_url` in remote config
3. Release a new version of the app

⚠️ For hotfix, you can only update the `remote_url` but you need to release a new version of the app since firebase remote config is not updated with 100% of the users.
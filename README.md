### How to update app icon and splash screen ?
Edit `assets_generation/AppTemplate.fig`
    - Export each individual icon assets in `assets_generation/icon`
    - Export each individual splash screen assets in `assets_generation/splash_screen`

Run `sh ./scripts/generate_launcher_icons.sh`
Run `sh ./scripts/generate_splash_screens.sh`

### How Firebase Remote Config works ?
string variable `min_app_version_ios` is used to check if the app is up to date on the app store
string variable `min_app_version_android` is used to check if the app is up to date on the play store
string variable `remote_url` is used to update the remote url for the app

### How to update url for the app ?
1. Update `env/.env` with the new url
2. Update `remote_url` in remote config
3. Upload a new PROD_RUNTIME_ENV_B64 to github secrets (see `/scripts/generate_env_ci.sh` for the format)
4. Release a new version of the app

⚠️ For hotfix, you can only update the `remote_url` but you need to release a new version of the app since firebase remote config is not updated with 100% of the users.

### How to deploy the app ?
- Run `sh ./scripts/release_militant_wrapper.sh <version_number>`
Example: `sh ./scripts/release_militant_wrapper.sh 1.0.0`

- On App Store Connect, you need to create a new version and submit it for review.
- On Play Store, the review process is automatic.
- When review is done for both stores, you can deploy the app.
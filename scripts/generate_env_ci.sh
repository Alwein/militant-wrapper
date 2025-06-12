#! /bin/bash

rm ci/env.ci
cp scripts/build.env ci/env.ci

# echo -e "\nKEYSTORE_B64=" >> ci/env.ci
# cat android/keystore/passemploi.jks | base64 >> ci/env.ci

# echo -e "\nKEY_PROPERTIES_B64=" >> ci/env.ci
# cat android/key.properties | base64 >> ci/env.ci

echo -e "\nRUNTIME_ENV_B64=" >> ci/env.ci
cat env/.env | base64 >> ci/env.ci

echo -e "\APPLE_PROD_API_KEY_B64=" >> ci/env.ci
cat AuthKey_23NY374S8C.p8 | base64 >> ci/env.ci

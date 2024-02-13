export LOCATION="eastus"
export PROJECT_PREFIX="missisippi"
export PROJECT_SUFFIX="$(cat /dev/urandom | tr -dc 'a-z' | fold -w 8 | head -n 1)"
# export WINDOWS_OR_LINUX="windows"

if [ -f "./missisippi.json" ]; then
  export PROJECT_SUFFIX=$(jq -r '.PROJECT_SUFFIX' missisippi.json)
  export LOCATION=$(jq -r '.LOCATION' missisippi.json)
  export WINDOWS_OR_LINUX=$(jq -r '.WINDOWS_OR_LINUX' missisippi.json)
else
  echo "{\"PROJECT_SUFFIX\": \"${PROJECT_SUFFIX}\", \"LOCATION\": \"${LOCATION}\", \"WINDOWS_OR_LINUX\": \"${WINDOWS_OR_LINUX}\"}" > missisippi.json
fi

az group create --name "${PROJECT_PREFIX}-${PROJECT_SUFFIX}-rg" --location "${LOCATION}"

az deployment group create --resource-group "${PROJECT_PREFIX}-${PROJECT_SUFFIX}-rg" --template-file "./vm_windows.bicep" --parameters "./vm.bicepparam"

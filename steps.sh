# Variables
RESOURCE_GROUP="streamlit-on-azure"
LOCATION="westeurope"
APP_SVC_PLAN="streamlitplan"
WEB_APP_NAME="streamlitonazure"

# Login
az login

# Create resource group
az group create \
--name $RESOURCE_GROUP \
--location $LOCATION

# Create App Service Plan
az appservice plan create \
--name $APP_SVC_PLAN \
--resource-group $RESOURCE_GROUP \
--is-linux \
--sku S1

# Create Web App
az webapp create \
--resource-group $RESOURCE_GROUP \
--plan $APP_SVC_PLAN \
--name $WEB_APP_NAME \
--runtime "PYTHON|3.10"

# Make a zip with app.py and requirements.txt files
zip -r app.zip app.py requirements.txt startup.sh

# set SCM_DO_BUILD_DURING_DEPLOYMENT to true
az webapp config appsettings set \
--resource-group $RESOURCE_GROUP \
--name $WEB_APP_NAME \
--settings SCM_DO_BUILD_DURING_DEPLOYMENT=true

az webapp config set \
--resource-group $RESOURCE_GROUP \
--name $WEB_APP_NAME \
--startup-file startup.sh

# Deploy zip
az webapp deploy \
--resource-group $RESOURCE_GROUP \
--name $WEB_APP_NAME \
--type zip \
--src-path app.zip \
--verbose --async true

# Browse web app
az webapp browse \
--resource-group $RESOURCE_GROUP \
--name $WEB_APP_NAME

# Logs 
az webapp log tail \
--resource-group $RESOURCE_GROUP \
--name $WEB_APP_NAME

#!/bin/bash

# Set SWAGGER_API_KEY to access private resources
echo "SwaggerHub authorization: ${SWAGGER_API_KEY:-anonymous}"

API_VER='0.7.0'
COMMONS_VER='0.2.0'
CASE_VER='0.2.0'
DOCUMENT_VER='0.1.0'
MEDIA_VER='0.2.0'
CHANGE_VER='0.2.0'
ACCESS_CTRL_VER='0.1.0'

API_URL="https://api.swaggerhub.com/apis/CaseWorx/CwxAPI/$API_VER"
COMMONS_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxCommonsDomain/$COMMONS_VER"
CASE_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxCaseDomain/$CASE_VER"
DOCUMENT_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxDocumentDomain/$DOCUMENT_VER"
MEDIA_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxMediaDomain/$MEDIA_VER"
CHANGE_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxChangeDomain/$CHANGE_VER"
ACCESS_CTRL_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxAccessControlDomain/$ACCESS_CTRL_VER"

BUILD_DIR='openapi'

API_FNAME='cwx-api.yaml'
COMMONS_FNAME='cwx-commons-domain.yaml'
CASE_FNAME='cwx-case-domain.yaml'
DOCUMENT_FNAME='cwx-document-domain.yaml'
MEDIA_FNAME='cwx-media-domain.yaml'
CHANGE_FNAME='cwx-change-domain.yaml'
ACCESS_CTRL_FNAME='cwx-access_ctrl-domain.yaml'

API_RESOLVED_FNAME='cwx-api-resolved.yaml'

echo "Building CaseWorx API v$API_VER..."

mkdir -p $BUILD_DIR
rm -f $BUILD_DIR/*

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$API_URL/swagger.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$API_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$COMMONS_URL/domain.yaml" | \
	sed -e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$COMMONS_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$CASE_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$CASE_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$DOCUMENT_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$DOCUMENT_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$MEDIA_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$MEDIA_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$CHANGE_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$ACCESS_CTRL_URL|$ACCESS_CTRL_FNAME|" \
		>$BUILD_DIR/$CHANGE_FNAME

curl -s -H "Authorization: ${SWAGGER_API_KEY}" -X GET "$ACCESS_CTRL_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		-e "s|$CHANGE_URL|$CHANGE_FNAME|" \
		>$BUILD_DIR/$ACCESS_CTRL_FNAME

swagger-cli validate $BUILD_DIR/$API_FNAME
swagger-cli bundle --outfile $BUILD_DIR/$API_RESOLVED_FNAME --type yaml $BUILD_DIR/$API_FNAME
swagger-cli validate $BUILD_DIR/$API_RESOLVED_FNAME

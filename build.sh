API_VER='0.3.4'
COMMONS_VER='0.0.1'
CASE_VER='0.0.1'
DOCUMENT_VER='0.0.1'
MEDIA_VER='0.0.1'

API_URL="https://api.swaggerhub.com/apis/CaseWorx/CwxAPI/$API_VER"
COMMONS_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxCommonsDomain/$COMMONS_VER"
CASE_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxCaseDomain/$CASE_VER"
DOCUMENT_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxDocumentDomain/$DOCUMENT_VER"
MEDIA_URL="https://api.swaggerhub.com/domains/CaseWorx/CwxMediaDomain/$MEDIA_VER"

BUILD_DIR='openapi'

API_FNAME='cwx-api.yaml'
COMMONS_FNAME='cwx-commons-domain.yaml'
CASE_FNAME='cwx-case-domain.yaml'
DOCUMENT_FNAME='cwx-document-domain.yaml'
MEDIA_FNAME='cwx-media-domain.yaml'

API_RESOLVED_FNAME='cwx-api-resolved.yaml'

echo "Building CaseWorx API v$API_VER..."

mkdir -p $BUILD_DIR
rm -f $BUILD_DIR/*

curl -X GET "$API_URL/swagger.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		>$BUILD_DIR/$API_FNAME

curl -X GET "$COMMONS_URL/domain.yaml" | \
	sed -e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		>$BUILD_DIR/$COMMONS_FNAME

curl -X GET "$CASE_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		>$BUILD_DIR/$CASE_FNAME

curl -X GET "$DOCUMENT_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$MEDIA_URL|$MEDIA_FNAME|" \
		>$BUILD_DIR/$DOCUMENT_FNAME

curl -X GET "$MEDIA_URL/domain.yaml" | \
	sed -e "s|$COMMONS_URL|$COMMONS_FNAME|" \
		-e "s|$CASE_URL|$CASE_FNAME|" \
		-e "s|$DOCUMENT_URL|$DOCUMENT_FNAME|" \
		>$BUILD_DIR/$MEDIA_FNAME

swagger-cli validate $BUILD_DIR/$API_FNAME
swagger-cli bundle --outfile $BUILD_DIR/$API_RESOLVED_FNAME --type yaml $BUILD_DIR/$API_FNAME
swagger-cli validate $BUILD_DIR/$API_RESOLVED_FNAME
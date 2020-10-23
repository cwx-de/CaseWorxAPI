# Change Log
------------

## CaseWorx API v0.10.0
----------------------
- add x-api-key header to all requests (CwxCommonsDomain 0.3.0, CwxChangeDomain 0.5.0, CwxDocumentDomain 0.2.0)
- clean up the MIME types declarations (CwxMediaDomain 0.5.0)

## CaseWorx API v0.9.0
----------------------
- add application/vnd.ms-outlook to the list of supported MIME types to let Outlook msg files through (CwxMediaDomain v0.4.0)

## CaseWorx API v0.8.0
----------------------
- specify maximum media size for partial upload and set to 60MB (CwxMediaDomain v0.3.0)

## CaseWorx API v0.7.1
----------------------
- remove `mark-for-delete` from `Change` schema, `action` enum (CwxChangeDomain v0.2.1)

## CaseWorx API v0.7.0
----------------------
- added properties `state` and `filename` to responses to /cases/{caseId}/documents and /cases/{caseId}/documents/{documentId}

## CaseWorx API v0.6.0
----------------------
- added support for setting Access Control List on a case
- added property `status` to the Error schema, `code` is now deprecated

## CaseWorx API v0.5.1
----------------------
- bugfix release

## CaseWorx API v0.5.0
----------------------

### Added
- added correlation ID header to improve traceability
- added HTTP 429 response to all requests to accommodate throttling
- added required OpenID scopes in security schema
- upgrade CwxCommonsDomain to v0.1.0
- upgrade CwxCaseDomain to v0.1.0
- upgrade CwxChangeDomain to v0.1.0
- upgrade CwxMediaDomain to v0.1.0

## CaseWorx API v0.4.0
----------------------

### Added
- Added endpoints supporting audit log retrieval
- Add the parameter to select download of a specific media layer

### Changed
- Partial upload is always asynchronous, removed HTTP 201 response

## CaseWorx API v0.3.4
----------------------

### Added
- Restructured API definition
- Added delete operations on a case and a document
- Added support for partial upload and download

### Changed
- Simple media upload/download request size limit decreased to 4MB
- Refined restrictions on case and document IDs

## CaseWorx API v0.0.6
----------------------

### Added
- OAuth2 Authorization Code grant flow support
- API key support
- List all cases
- List the documents in a specific case
- Retrieve selected metadata of a document
- Create a case
- Upload a document media (5 MB max.)
- Download a document media (5 MB max.)
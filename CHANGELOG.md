# Change Log
------------

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
- Added suport for partial upload and download

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
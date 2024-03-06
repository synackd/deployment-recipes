#
# Request Access Token
#

# Create OAuth2 client
POST http://hydra:4445/admin/clients
{
	"client_name": "smd-deletor",
	"token_endpoint_auth_method": "client_secret_post",
	"scope": "openid email profile read",
	"grant_types": ["client_credentials"],
	"response_types": ["token"],
	"redirect_uris": ["http://hydra:5555/callback"],
	"state": "12345678910"
}

HTTP 201
[Captures]
client_id: jsonpath "$.client_id"
client_secret: jsonpath "$.client_secret"
registration_access_token: jsonpath "$.registration_access_token"

# Authorize OAuth2 client
POST http://hydra:4444/oauth2/auth
Authorization: Bearer {{registration_access_token}}
Content-Type: application/x-www-form-urlencoded
[FormParams]
grant_type: client_credentials
scope: read
client_id: {{client_id}}
client_secret: {{client_secret}}
redirect_uri: http://hydra:5555/callback
response_type: token
state: 12345678910

HTTP 302

# Perform token grant
POST http://hydra:4444/oauth2/token
Authorization: Bearer {{registration_access_token}}
Content-Type: application/x-www-form-urlencoded
[FormParams]
grant_type: client_credentials
client_id: {{client_id}}
client_secret: {{client_secret}}
scope: read

HTTP 200
[Captures]
access_token: jsonpath "$.access_token"

#
# Perform SMD Actions
#

# Delete RedfishEndpoint for first XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete RedfishEndpoint for third XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete RedfishEndpoint for first XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete RedfishEndpoint for third XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete RedfishEndpoint for first XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete RedfishEndpoint for third XName.
DELETE http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure RedfishEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for first XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c0s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for first XName.
GET http://smd:27779/hsm/v2/State/Components/x0c0s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for third XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c0s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for third XName.
GET http://smd:27779/hsm/v2/State/Components/x0c0s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for first XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c1s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for first XName.
GET http://smd:27779/hsm/v2/State/Components/x0c1s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for third XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c1s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for third XName.
GET http://smd:27779/hsm/v2/State/Components/x0c1s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for first XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c2s1b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for first XName.
GET http://smd:27779/hsm/v2/State/Components/x0c2s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Delete Component for third XName.
DELETE http://smd:27779/hsm/v2/State/Components/x0c2s3b0
Authorization: Bearer {{access_token}}

HTTP 200

# Ensure Component was deleted for third XName.
GET http://smd:27779/hsm/v2/State/Components/x0c2s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c0s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for second XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c0s2b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c0s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c1s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for second XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c1s2b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c1s3b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for first XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c2s1b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for second XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c2s2b0
Authorization: Bearer {{access_token}}

HTTP 404

# Ensure ComponentEndpoint was deleted for third XName.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c2s3b0
Authorization: Bearer {{access_token}}

HTTP 404

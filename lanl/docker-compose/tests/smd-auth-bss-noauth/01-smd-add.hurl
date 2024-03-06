#
# Request Access Token
#

# Create OAuth2 client
POST http://hydra:4445/admin/clients
{
	"client_name": "smd-creator",
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

# Create SMD Redfish endpoints for first mac.
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c0s1b0",
	"Name": "x0c0s1b0",
	"Hostname": "x0c0s1b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:89:9d",
	"IPAddress": "10.254.2.10",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c0s1b0",
			"Id": "x0c0s1b0",
			"Name": "x0c0s1b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c0s1b0n0",
			"Id": "x0c0s1b0n0",
			"Name": "x0c0s1b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0",
				"Id": "x0c0s1b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c0s1b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:00:30:00",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:00:30:00",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c0s1b0"

# Create SMD Redfish endpoints for third mac (the second will be deleted).
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c0s3b0",
	"Name": "x0c0s3b0",
	"Hostname": "x0c0s3b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:89:9e",
	"IPAddress": "10.254.2.11",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c0s3b0",
			"Id": "x0c0s3b0",
			"Name": "x0c0s3b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c0s3b0n0",
			"Id": "x0c0s3b0n0",
			"Name": "x0c0s3b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0",
				"Id": "x0c0s3b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c0s3b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:00:30:04",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:00:30:04",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c0s3b0"

#
# Get RedfishEndpoints we just added.
#

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c0s1b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c0s1b0",
#	 "Hostname": "x0c0s1b0",
#	 "Domain": "",
#	 "FQDN": "x0c0s1b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:89:9d",
#	 "IPAddress": "10.254.2.10",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s1b0"
jsonpath "$.Hostname" == "x0c0s1b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:89:9d"
jsonpath "$.IPAddress" == "10.254.2.10"

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c0s3b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c0s3b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c0s3b0",
#	 "Hostname": "x0c0s3b0",
#	 "Domain": "",
#	 "FQDN": "x0c0s3b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:89:9e",
#	 "IPAddress": "10.254.2.11",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s3b0"
jsonpath "$.Hostname" == "x0c0s3b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:89:9e"
jsonpath "$.IPAddress" == "10.254.2.11"

# Create SMD Redfish endpoints for first nid.
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c1s1b0",
	"Name": "x0c1s1b0",
	"Hostname": "x0c1s1b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:90:9d",
	"IPAddress": "10.254.2.10",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c1s1b0",
			"Id": "x0c1s1b0",
			"Name": "x0c1s1b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c1s1b0n0",
			"Id": "x0c1s1b0n0",
			"Name": "x0c1s1b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0",
				"Id": "x0c1s1b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c1s1b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:02:30:00",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:02:30:00",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c1s1b0"

# Create SMD Redfish endpoints for third nid (the second will be deleted).
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c1s3b0",
	"Name": "x0c1s3b0",
	"Hostname": "x0c1s3b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:90:9e",
	"IPAddress": "10.254.2.11",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c1s3b0",
			"Id": "x0c1s3b0",
			"Name": "x0c1s3b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c1s3b0n0",
			"Id": "x0c1s3b0n0",
			"Name": "x0c1s3b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0",
				"Id": "x0c1s3b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c1s3b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:02:30:04",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:02:30:04",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c1s3b0"

#
# Get RedfishEndpoints we just added.
#

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c1s1b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c1s1b0",
#	 "Hostname": "x0c1s1b0",
#	 "Domain": "",
#	 "FQDN": "x0c1s1b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:90:9d",
#	 "IPAddress": "10.254.2.10",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s1b0"
jsonpath "$.Hostname" == "x0c1s1b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:90:9d"
jsonpath "$.IPAddress" == "10.254.2.10"

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c1s3b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c1s3b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c1s3b0",
#	 "Hostname": "x0c1s3b0",
#	 "Domain": "",
#	 "FQDN": "x0c1s3b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:90:9e",
#	 "IPAddress": "10.254.2.11",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s3b0"
jsonpath "$.Hostname" == "x0c1s3b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:90:9e"
jsonpath "$.IPAddress" == "10.254.2.11"

# Create SMD Redfish endpoints for first xname.
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c2s1b0",
	"Name": "x0c2s1b0",
	"Hostname": "x0c2s1b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:89:9d",
	"IPAddress": "10.254.2.10",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c2s1b0",
			"Id": "x0c2s1b0",
			"Name": "x0c2s1b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c2s1b0n0",
			"Id": "x0c2s1b0n0",
			"Name": "x0c2s1b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0",
				"Id": "x0c2s1b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c2s1b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:04:30:00",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:04:30:00",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c2s1b0"

# Create SMD Redfish endpoints for third xname (the second will be deleted).
POST http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}
{
	"ID": "x0c2s3b0",
	"Name": "x0c2s3b0",
	"Hostname": "x0c2s3b0",
	"FQDN": "",
	"User": "admin",
	"Password": "password",
	"MACRequired": true,
	"RediscoverOnUpdate": false,
	"MACAddr": "ae:12:e2:ff:89:9e",
	"IPAddress": "10.254.2.11",
	"Chassis": [
		{
			"@odata.id": "/redfish/v1/Chassis/x0c2s3b0",
			"Id": "x0c2s3b0",
			"Name": "x0c2s3b0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Card",
			"DepthMm": 0,
			"Description": "SS11 200Gb 2P NIC Mezz",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "R4K44A",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "On",
			"SKU": "",
			"SerialNumber": "TII0542809843",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/Enclosure",
			"Id": "Enclosure",
			"Name": "Enclosure",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Enclosure",
			"DepthMm": 0,
			"Description": "BardPeakNC",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "BardPeakNC",
			"PartNumber": "P37085-001.A",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "WFA2537623994",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		},
		{
			"@odata.id": "/redfish/v1/Chassis/x0c2s3b0n0",
			"Id": "x0c2s3b0n0",
			"Name": "x0c2s3b0n0",
			"@odata.context": "",
			"@odata.type": "#Chassis.v1_5_1.Chassis",
			"AssetTag": "",
			"ChassisType": "Blade",
			"DepthMm": 0,
			"Description": "",
			"Drives@odata.count": 0,
			"EnvironmentalClass": "",
			"HeightMm": 0,
			"IndicatorLED": "",
			"Location": {
				"AltitudeMeters": 0,
				"Contacts": null,
				"Info": "",
				"InfoFormat": "",
				"Latitude": 0,
				"Longitude": 0,
				"PartLocation": {
					"LocationOrdinalValue": 0,
					"LocationType": "",
					"Orientation": "",
					"Reference": "",
					"ServiceLabel": ""
				},
				"Placement": {
					"AdditionalInfo": "",
					"Rack": "",
					"RackOffset": 0,
					"RackOffsetUnits": "",
					"Row": ""
				},
				"PostalAddress": {
					"AdditionalCode": "",
					"AdditionalInfo": "",
					"Building": "",
					"City": "",
					"Community": "",
					"Country": "",
					"District": "",
					"Division": "",
					"Floor": "",
					"GPSCoords": "",
					"HouseNumber": 0,
					"HouseNumberSuffix": "",
					"Landmark": "",
					"LeadingStreetDirection": "",
					"Location": "",
					"Name": "",
					"Neighborhood": "",
					"POBox": "",
					"PlaceType": "",
					"PostalCode": "",
					"Road": "",
					"RoadBranch": "",
					"RoadPostModifier": "",
					"RoadPreModifier": "",
					"RoadSection": "",
					"RoadSubBranch": "",
					"Room": "",
					"Seat": "",
					"Street": "",
					"StreetSuffix": "",
					"Territory": "",
					"TrailingStreetSuffix": "",
					"Unit": ""
				}
			},
			"Manufacturer": "HPE",
			"Model": "",
			"PartNumber": "",
			"PhysicalSecurity": {
				"IntrusionSensor": "",
				"IntrusionSensorNumber": 0,
				"IntrusionSensorReArm": ""
			},
			"PowerState": "",
			"SKU": "",
			"SerialNumber": "",
			"Status": {
				"Health": "OK",
				"HealthRollup": "",
				"State": "Enabled"
			},
			"UUID": "",
			"WeightKg": 0,
			"WidthMm": 0,
			"SupportedResetTypes": null
		}
	],
	"Systems": [
		{
			"Data": {
				"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0",
				"Id": "x0c2s3b0n0",
				"@odata.context": "",
				"@odata.type": "#ComputerSystem.v1_5_0.ComputerSystem",
				"AssetTag": "",
				"BiosVersion": "ex235a.bios-1.3.6",
				"Boot": {
					"BootOrder": [
						"ME0-PXE-IP4",
						"ME0-PXE-IP6",
						"HSN0-PXE-IP4",
						"HSN0-PXE-IP6",
						"HSN1-PXE-IP4",
						"HSN1-PXE-IP6",
						"HSN2-PXE-IP4",
						"HSN3-PXE-IP4",
						"HSN2-PXE-IP6",
						"HSN3-PXE-IP6",
						"Boot000B"
					]
				},
				"Description": "BardPeakNC",
				"HostName": "",
				"HostWatchdogTimer": {
					"FunctionEnabled": false,
					"Status": {
						"State": ""
					},
					"TimeoutAction": "",
					"WarningAction": ""
				},
				"HostingRoles": null,
				"IndicatorLED": "",
				"Manufacturer": "HPE",
				"MemorySummary": {
					"MemoryMirroring": "",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"TotalSystemMemoryGiB": 512,
					"TotalSystemPersistentMemoryGiB": 0
				},
				"Model": "HPE CRAY EX235a",
				"Name": "x0c2s3b0n0",
				"PCIeDevices@odata.count": 0,
				"PCIeFunctions@odata.count": 0,
				"PartNumber": "P37085-001.A",
				"PowerRestorePolicy": "",
				"PowerState": "On",
				"ProcessorSummary": {
					"Count": 9,
					"LogicalProcessorCount": 0,
					"Model": "AMD INSTINCT MI200 (MCM) OAM LC",
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					}
				},
				"Redundancy": "",
				"Redundancy@odata.count": "",
				"SKU": "",
				"SerialNumber": "WFA2537623994",
				"Status": {
					"Health": "OK",
					"HealthRollup": "",
					"State": "Enabled"
				},
				"SubModel": "",
				"SystemType": "Physical",
				"TrustedModules": null,
				"UUID": "",
				"SupportedResetTypes": null,
				"ManagedBy": null
			},
			"EthernetInterfaces": [
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet2",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet2",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet2/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/ManagementEthernet",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "Node Maintenance Network",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "ManagementEthernet",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "02:0b:b8:04:30:04",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": null,
					"PermanentMACAddress": "02:0b:b8:04:30:04",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet1",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet1",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet1/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet3",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet3",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet3/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": ""
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				},
				{
					"@odata.context": "",
					"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet0",
					"@odata.type": "#EthernetInterface.v1_3_0.EthernetInterface",
					"AutoNeg": false,
					"DHCPv4": {
						"DHCPEnabled": false,
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseGateway": false,
						"UseNTPServers": false,
						"UseStaticRoutes": false
					},
					"DHCPv6": {
						"OperatingMode": "",
						"UseDNSServers": false,
						"UseDomainName": false,
						"UseNTPServers": false,
						"UseRapidCommit": false
					},
					"Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
					"EndpointsCount": 0,
					"EthernetInterfaceType": "",
					"FQDN": "",
					"FullDuplex": false,
					"HostName": "",
					"IPv4Addresses": null,
					"IPv4StaticAddresses": null,
					"IPv6AddressPolicyTable": null,
					"IPv6Addresses": null,
					"IPv6DefaultGateway": "",
					"IPv6StaticAddresses": null,
					"IPv6StaticDefaultGateways": null,
					"Id": "HPCNet0",
					"InterfaceEnabled": false,
					"LinkStatus": "",
					"MACAddress": "Not Available",
					"MTUSize": 0,
					"MaxIPv6StaticAddresses": 0,
					"Name": "",
					"NameServers": null,
					"Oem": {
						"Hpe": {
							"CassiniMetrics": {
								"@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet0/Oem/Hpe/CassiniMetrics"
							}
						}
					},
					"PermanentMACAddress": "",
					"SpeedMbps": 0,
					"StatelessAddressAutoConfig": {
						"IPv4AutoConfigEnabled": false,
						"IPv6AutoConfigEnabled": false
					},
					"StaticNameServers": null,
					"Status": {
						"Health": "",
						"HealthRollup": "",
						"State": "Enabled"
					},
					"UefiDevicePath": "",
					"VLAN": {
						"VLANEnable": false,
						"VLANId": 0
					}
				}
			]
		}
	]
}

HTTP 201
Content-Type: application/json
[Asserts]
jsonpath "$[0].URI" == "/hsm/v2/Inventory/RedfishEndpoints/x0c2s3b0"

#
# Get RedfishEndpoints we just added.
#

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c2s1b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c2s1b0",
#	 "Hostname": "x0c2s1b0",
#	 "Domain": "",
#	 "FQDN": "x0c2s1b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:89:9d",
#	 "IPAddress": "10.254.2.10",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s1b0"
jsonpath "$.Hostname" == "x0c2s1b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:89:9d"
jsonpath "$.IPAddress" == "10.254.2.10"

GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints/x0c2s3b0
Authorization: Bearer {{access_token}}
# Response should be:
#
# {
#	 "ID": "x0c2s3b0",
#	 "Type": "NodeBMC",
#	 "Name": "x0c2s3b0",
#	 "Hostname": "x0c2s3b0",
#	 "Domain": "",
#	 "FQDN": "x0c2s3b0",
#	 "Enabled": true,
#	 "User": "admin",
#	 "Password": "password",
#	 "MACRequired": true,
#	 "MACAddr": "ae:12:e2:ff:89:9e",
#	 "IPAddress": "10.254.2.11",
#	 "RediscoverOnUpdate": false,
#	 "DiscoveryInfo": {
#		 "LastDiscoveryStatus": "NotYetQueried"
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s3b0"
jsonpath "$.Hostname" == "x0c2s3b0"
jsonpath "$.MACAddr" == "ae:12:e2:ff:89:9e"
jsonpath "$.IPAddress" == "10.254.2.11"

# Check that fetching RedfishEndpoints without specifying an xname works.
GET http://smd:27779/hsm/v2/Inventory/RedfishEndpoints
Authorization: Bearer {{access_token}}

# Response should have >0 entry with a successful return code.
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.[*]" count > 0

#
# Get Components we added corresponding to the MAC addresses
#

GET http://smd:27779/hsm/v2/State/Components/x0c0s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c0s1b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s1b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

GET http://smd:27779/hsm/v2/State/Components/x0c0s3b0
Authorization: Bearer {{access_token}}
# Response should be:
#
# {
#	 "ID": "x0c0s3b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s3b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

#
# Get Components we added corresponding to the MAC addresses
#

GET http://smd:27779/hsm/v2/State/Components/x0c1s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c1s1b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s1b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

GET http://smd:27779/hsm/v2/State/Components/x0c1s3b0
Authorization: Bearer {{access_token}}
# Response should be:
#
# {
#	 "ID": "x0c1s3b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s3b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

#
# Get Components we added corresponding to the MAC addresses
#

GET http://smd:27779/hsm/v2/State/Components/x0c2s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c2s1b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s1b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

GET http://smd:27779/hsm/v2/State/Components/x0c2s3b0
Authorization: Bearer {{access_token}}
# Response should be:
#
# {
#	 "ID": "x0c2s3b0",
#	 "Type": "Node",
#	 "Enabled": false
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s3b0"
jsonpath "$.Type" == "Node"
jsonpath "$.Enabled" == true

# Check that fetching Components without specifying an xname works.
GET http://smd:27779/hsm/v2/State/Components
Authorization: Bearer {{access_token}}

# Response should have >0 entry with a successful return code.
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.[*]" count > 0

#
# Get ComponentEndpoints we added corresponding to the MAC addresses
#

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c0s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c0s1b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c0s1b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c0s1b0",
#	 "RedfishURL": "x0c0s1b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:00:30:00"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s1b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s1b0"

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c0s3b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c0s3b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c0s3b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c0s3b0",
#	 "RedfishURL": "x0c0s3b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:00:30:04"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c0s3b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c0s3b0"

#
# Get ComponentEndpoints we added corresponding to the NIDs
#

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c1s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c1s1b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c1s1b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c1s1b0",
#	 "RedfishURL": "x0c1s1b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:02:30:00"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s1b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s1b0"
jsonpath "$.RedfishSystemInfo.EthernetNICInfo[1].MACAddress" == "02:0b:b8:02:30:00"

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c1s3b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c1s3b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c1s3b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c1s3b0",
#	 "RedfishURL": "x0c1s3b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:02:30:04"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c1s3b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c1s3b0"
jsonpath "$.RedfishSystemInfo.EthernetNICInfo[1].MACAddress" == "02:0b:b8:02:30:04"

#
# Get ComponentEndpoints we added corresponding to the XNames
#

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c2s1b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c2s1b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c2s1b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c2s1b0",
#	 "RedfishURL": "x0c2s1b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:04:30:00"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s1b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s1b0"
jsonpath "$.RedfishSystemInfo.EthernetNICInfo[1].MACAddress" == "02:0b:b8:04:30:00"

GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints/x0c2s3b0
Authorization: Bearer {{access_token}}

# Response should be:
#
# {
#	 "ID": "x0c2s3b0",
#	 "Type": "Node",
#	 "RedfishType": "ComputerSystem",
#	 "RedfishSubtype": "Physical",
#	 "OdataID": "",
#	 "RedfishEndpointID": "x0c2s3b0",
#	 "Enabled": true,
#	 "RedfishEndpointFQDN": "x0c2s3b0",
#	 "RedfishURL": "x0c2s3b0",
#	 "ComponentEndpointType": "ComponentEndpointComputerSystem",
#	 "RedfishSystemInfo": {
#		 "EthernetNICInfo": [
#			 {
#				 "RedfishId": "HPCNet2",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet2",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "ManagementEthernet",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/ManagementEthernet",
#				 "Description": "Node Maintenance Network",
#				 "MACAddress": "02:0b:b8:04:30:04"
#			 },
#			 {
#				 "RedfishId": "HPCNet1",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet1",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet3",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet3",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 },
#			 {
#				 "RedfishId": "HPCNet0",
#				 "@odata.id": "/redfish/v1/Systems/x0c2s3b0n0/EthernetInterfaces/HPCNet0",
#				 "Description": "SS11 200Gb 2P NIC Mezz REV02 (HSN)",
#				 "MACAddress": "Not Available"
#			 }
#		 ]
#	 }
# }
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.ID" == "x0c2s3b0"
jsonpath "$.RedfishSystemInfo.EthernetNICInfo[1].MACAddress" == "02:0b:b8:04:30:04"

# Check that fetching ComponentEndpoints without specifying an xname works.
GET http://smd:27779/hsm/v2/Inventory/ComponentEndpoints
Authorization: Bearer {{access_token}}

# Response should have >0 entry with a successful return code.
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.[*]" count > 0

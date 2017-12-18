<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="DisasterNeedsMap.aspx.cs" Inherits="CrowdRelief.Account_Organization_DisasterNeedsMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
	<style>
		/* Always set the map height explicitly to define the size of the div
		* element that contains the map. */

		#map {position: relative;}
		#map {position: absolute; top: 0; right: 0; bottom: 0; left: 0;}

		#legend {
			font-family: Arial, sans-serif;
			background: #fff;
			padding: 10px;
			margin: 10px;
			border: 3px solid #000;
			/*top:60px;
			height:300px;
			left:3px;
			width:150px;*/
		}

		#legend h3 {
			margin-top: 0;
		}

		#legend img {
			vertical-align: middle;
		}
		.gm-style-iw {
			min-width: 800px; 
			min-height: 50px;
			}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">

<div id="wrapper">
	<div class="content animate-panel" data-child="hpanel">
		<div class="container-fluid" id="divFormFields" runat="server">
			<div class="row">
				<div id="map"></div>
				<div id="legend" class="hidden-xs"><h3>Legend</h3><b>Flood Victim?</b> Get your<br />household needs survey.<br />Call 225–289–3950<br />9-3 M-F 9-12 on Sat</div>
				<script>

						var map;
						function initMap() {
							map = new google.maps.Map(document.getElementById('map'), {
								zoom: 11,
								center: new google.maps.LatLng(30.495287, -90.746696),
								mapTypeId: 'roadmap'
						});

						var infowindow = new google.maps.InfoWindow();

						var iconBase = 'https://www.crowdrelief.net/images/Icon/';
						var icons = {
							donate: {
								name: 'Donate',
								icon: iconBase + 'MapIcon-Fusia.png'
							},
							survey: {
								name: 'First Follow Up',
								icon: iconBase + 'MapIcon-Colored.png'
							},
							casemanagment: {
								name: 'Case Management',
								icon: iconBase + 'MapIcon-Blue.png'
							},
							story: {
								name: 'Story Needed',
								icon: iconBase + 'MapIcon-Yellow.png'
							},
							photos: {
								name: 'Photos Needed',
								icon: iconBase + 'MapIcon-Red.png'
							},
							complete: {
								name: 'Case Complete',
								icon: iconBase + 'MapIcon-Green.png'
							},
							followup: {
								name: 'First Follow Up',
								icon: iconBase + 'MapIcon-Grey.png'
							}
						};

						function addMarker(clientLocation) {
							var marker = new google.maps.Marker({
								position: clientLocation.position,
								icon: icons[clientLocation.type].icon,	
								map: map,
							});
							// must be a string (or a DOM node).
							var content = "" + clientLocation.title
							google.maps.event.addListener(marker, 'click', (function (marker, content, infowindow) {
								return function (evt) {
									infowindow.setContent(content);
									infowindow.open(map, marker);
								};
							})(marker, content, infowindow));

						}



						//function addMarker(clientLocation) {
						//	var marker = new google.maps.Marker({
						//		position: clientLocation.position,
						//		icon: icons[clientLocation.type].icon,
						//		map: map
						//	});
						//}
					
						<%=mapCoordinates%>

						for (var i = 0, clientLocation; clientLocation = clientLocations[i]; i++) {
							addMarker(clientLocation);
						}

						var legend = document.getElementById('legend');
						for (var key in icons) {
							var type = icons[key];
							var name = type.name;
							var icon = type.icon;
							var div = document.createElement('div');
							div.innerHTML = '<img src="' + icon + '"> ' + name;
							legend.appendChild(div);
						}

						map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);
					}

				</script>
				<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDpoaEOW0WO57jGAv8rPzoDHIxXHB0k_44&callback=initMap">
				</script>
			</div>
		</div>
	</div>
</div>
</asp:Content>
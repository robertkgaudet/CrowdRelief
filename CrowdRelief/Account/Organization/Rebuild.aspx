<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="Rebuild.aspx.cs" Inherits="Account_Organization_Rebuild" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
	<script src="/Scripts/vendor/jquery-ui/jquery-ui.min.js"></script>
	<script src="/Scripts/vendor/iCheck/icheck.min.js"></script>
	<script src="/Scripts/vendor/chartjs/Chart.min.js"></script>
	<script src="/Scripts/vendor/sparkline/index.js"></script>
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDQTpXj82d8UpCi97wzo_nKXL7nYrd4G70"></script>

	<script type="text/javascript">

		$(document).ready(function ()
		{
			$('.btnUpdateProgress').click(function(){
				window.location.href='RebuildProgressUpdates.aspx?survivorId=<%=survivorId%>';
				return false;
			})

			// When the window has finished loading google map
			google.maps.event.addDomListener(window, 'load', init);

			function init() {
				// Options for Google map
				// More info see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
				var mapOptions1 = {
					zoom: 10,
					center: new google.maps.LatLng(<%=latidude%>, <%=longitude%>),
					// Style for Google Maps
				};

				// Get all html elements for map
				var mapElement1 = document.getElementById('map1');

				// Create the Google Map using elements
				var map1 = new google.maps.Map(mapElement1, mapOptions1);

				var image = '/Images/Icon/MapIcon-Red.png';
				var beachMarker = new google.maps.Marker({
					position: {lat: <%=latidude%>, lng: <%=longitude%>},
					map: map1,
					icon: image
				});
			}



<%--			function initMap() {
				var map = new google.maps.Map(document.getElementById('map1'), {
					zoom: 4,
					center: {lat: <%=latidude%>, lng: <%=longitude%>}
				});

				var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
				var beachMarker = new google.maps.Marker({
					position: {lat: <%=latidude%>, lng: <%=longitude%>},
					map: map,
					icon: image
				});
			}--%>








			$(function () {

				/**
				 * Options for Line chart
				 */


				var yRebuildLabels = {
					<%=yRebuildLabels%>
				}

				var yOverallLabels = {
					<%=yOverallLabels%>
				}

				var lineRebuildData = {
					labels: [<%=rebuildProgressSpan%>],
					datasets: [
						{
							label: "My Rebuild Progress",
							backgroundColor: "rgba(98,203,49,0.5)",
							borderColor: "rgba(98,203,49,0.8)",
							highlightFill: "rgba(98,203,49,0.75)",
							highlightStroke: "rgba(98,203,49,1)",
							borderWidth: 1,
							data: [<%=rebuildProgressDataUser%>]
						},
						{
							label: "Community Rebuild Progress",
							backgroundColor: "rgba(220,220,220,0.5)",
							borderColor: "rgba(220,220,220,0.8)",
							highlightFill: "rgba(220,220,220,0.75)",
							highlightStroke: "rgba(220,220,220,1)",
							borderWidth: 1,
							data: [<%=rebuildProgressDataAvg%>]
						}
					]
				};

				var lineOptionsRebuild = {
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'Month'
							}
						}],
						yAxes: [{
							display: true,
							ticks: {
								beginAtZero: true,
								steps: 10,
								stepValue: 10,
								max: <%=rebuildLabelCount%>,
								callback: function(value, index, values) {
									return yRebuildLabels[value];
								}
							}
						}]
					}
				};
					

				var ctx = document.getElementById("lineOptionsRebuild").getContext("2d");
				new Chart(ctx, { type: 'bar', data: lineRebuildData, options: lineOptionsRebuild });



				var lineOverallData = {
					labels: [<%=overallProgressSpan%>],
					datasets: [
						{
							label: "My Overall Progress",
							backgroundColor: "rgba(98,203,49,0.5)",
							borderColor: "rgba(98,203,49,0.8)",
							highlightFill: "rgba(98,203,49,0.75)",
							highlightStroke: "rgba(98,203,49,1)",
							borderWidth: 1,
							data: [<%=overallProgressDataUser%>]
						},
						{
							label: "Overall Community Progress",
							backgroundColor: "rgba(220,220,220,0.5)",
							borderColor: "rgba(220,220,220,0.8)",
							highlightFill: "rgba(220,220,220,0.75)",
							highlightStroke: "rgba(220,220,220,1)",
							borderWidth: 1,
							data: [<%=overallProgressDataAvg%>]
						}
					]
				};

				var lineOptionsOverall = {
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'Month'
							}
						}],
						yAxes: [{
							display: true,
							ticks: {
								beginAtZero: true,
								min: 0,
								max: <%=oveallLabelCount%>,
								steps: 11,
								callback: function (value, index, values) {
									return yOverallLabels[value];
								}
							}
						}]
					}
				};

				var ctx = document.getElementById("lineOptionsOverall").getContext("2d");
				new Chart(ctx, { type: 'bar', data: lineOverallData, options: lineOptionsOverall });


			});
		});
	</script>
	
	<style>

		#base
		{
			background: #555555;
			display: inline-block;
			height: 10px;
			margin-left: 1px;
			margin-top: 10px;
			position: relative;
			width: 15px;
		}
		#base:before
		{
		  border-bottom: 8px solid #555555;
		  border-left: 8px solid transparent;
		  border-right: 7px solid transparent;
		  content: "";
		  height: 0;
		  left: 0;
		  position: absolute;
		  top: -8px;
		  width: 0;
		}
		

		.post-logo
		{
			width:50px;
			float:left;
		}
		
		.StatusClassIceBlue {
			width: 7px;
			height: 7px;
			background: #5BC0DE;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassOnDeckYellow {
			width: 7px;
			height: 7px;
			background: #F0AD4E;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassActiveGreen {
			width: 7px;
			height: 7px;
			background: #5CB85C;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
		.StatusClassComplete {
			width: 7px;
			height: 7px;
			background: #428BCA;
			-moz-border-radius: 7px;
			-webkit-border-radius: 7px;
			border-radius: 7px;
			}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">
			<div id="wrapper">
				<div class="content animate-panel" data-child="hpanel">
<div class="normalheader ">
        <div class="row">
            <div class="col-md-6">
				<div class="hpanel">
					<div class="panel-body">
						<a class="small-header-action" href="">
							<div class="clip-header">
								<i class="fa fa-arrow-up"></i>
							</div>
						</a>
						<h2 class="font-light m-b-xs"><asp:Literal ID="litSurvivorNameHeader" runat="server"></asp:Literal> Home Rebuild</h2>
						<div class="m-b-sm border-bottom">
							Collaborating Organizations
						</div>
						<asp:Repeater ID="rptCollaborators" runat="server">
							<ItemTemplate>
								<a href="OrganizationProfile.aspx?organizationId=<%# DataBinder.Eval(Container.DataItem, "OrganizationId") %>">
									<img alt='<%# DataBinder.Eval(Container.DataItem, "Name") %>' class="img-thumbnail img-small" src='/Images/Organizations/<%# DataBinder.Eval(Container.DataItem, "Logo") %>' />
								</a>
							</ItemTemplate>
						</asp:Repeater>
						<div id="hbreadcrumb" class="pull-right">
							<ol class="hbreadcrumb breadcrumb">
								<li><a href="Default.aspx">Disasters</a></li>
								<li><span><a href="Rebuilds.aspx">Louisiana Flooding Home Rebuilds, August 2016</a></span></li>
								<li><span>Rebuild</span></li>
								<li class="active"><span><asp:Literal ID="litSurvivorNameBreadcrumb" runat="server"></asp:Literal></span></li>
							</ol>
						</div>
					</div>
				</div>
            </div>
            <div class="col-md-3">
                <div class="hpanel hbggreen">
                    <div class="panel-body">
                        <div class="text-center">
                            <h3>Progress</h3>
                            <p class="text-big font-light">
                                <%=progressPercent%>%
                            </p>
                            <button class="btn btn-default btn-sm btnUpdateProgress">Update Progress</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="hpanel hbgyellow">
                    <div class="panel-body">
                        <div class="text-center">
                            <h3>Volunteers Needed</h3>
                            <p class="text-big font-light">
								<asp:Literal ID="litVolunteers" runat="server"></asp:Literal>
                            </p>
							<div>
                            <small>
                                <asp:Literal ID="litVolunteersDifficulty" runat="server"></asp:Literal>
                            </small>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>

<div class="content">
	<div class="row">
		<div class="col-lg-4">
			<div class="hpanel hgreen">
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-8">
							<div id="divProgressBar" runat="server">
								<strong>Active Progress</strong> <%=progressPercent%>% Complete
								<div class="progress m-t-xs full progress-small">
									<div style="width:<%=progressPercent%>%" aria-valuemax="100" aria-valuemin="0" role="progressbar" class="progress-bar progress-bar-success">
										<span class="sr-only">10% Complete (success)</span>
									</div>
								</div>
							</div>
							<div class="alert alert-danger" id="divNoGo" runat="server">
								Project is on hold.
							</div>
							<h3><a href=""><asp:Literal ID="litSurvivorNameProfile" runat="server"></asp:Literal></a></h3>
							<div class="text-muted font-bold m-b-xs">
								<asp:Literal ID="litAddress" runat="server"></asp:Literal>
								<br />
								<asp:Literal ID="litCityStatZip" runat="server"></asp:Literal>
								<br />
								<asp:Literal ID="litPhoneNumber" runat="server"></asp:Literal>
								<br />
								<asp:Literal ID="litEmail" runat="server"></asp:Literal>
							</div>
							<dl class="dl-horizontal">
								<dt>Stage:</dt> <dd><div style="height:15px;" class='pull-left m-r-xs <%=statusClass%>'></div> <asp:Literal ID="litStage" runat="server"></asp:Literal></dd>
								<dt>Stage Detail:</dt> <dd><asp:Literal ID="litStageDetail" runat="server"></asp:Literal></dd>
								<dt>Beds:</dt> <dd><asp:Literal ID="litBeds" runat="server"></asp:Literal></dd>
								<dt>Baths:</dt> <dd><asp:Literal ID="litBaths" runat="server"></asp:Literal></dd>
								<dt>Square Feet:</dt> <dd><asp:Literal ID="litSquareFeet" runat="server"></asp:Literal></dd>
							</dl>	
						</div>
						<div class="col-sm-4">
							Difficulty
							<div class="border-top m-b-lg">
								<asp:Literal ID="litDifficulty" runat="server"></asp:Literal>
							</div>
							Qualifiers
							<div class="border-top">
								<br />
								<asp:Repeater ID="rpQualifiers" runat="server">
									<HeaderTemplate><ul style="margin-left:-10px;"></HeaderTemplate>
									<ItemTemplate>
										<li style="margin-left:-10px;"><%# DataBinder.Eval(Container.DataItem, "Status") %></li>
									</ItemTemplate>
									<FooterTemplate></ul></FooterTemplate>
								</asp:Repeater>
							</div>
						</div>
					</div>
				</div>
				<div class="panel-body">
					<dl>
						<dt>Description of Work</dt>
						<dd>
							<asp:Literal ID="litDescription" runat="server"></asp:Literal>
						</dd>
					</dl>
				</div>
				<div class="hpanel hblue">
					<section id="map">
						<div id="map1" style="height: 200px"></div>
					</section>
				</div>
			</div>
			<div class="hpanel">
				<div class="panel-heading hbuilt">
					Tasks
				</div>
				<div class="panel-body no-padding">
					<ul class="list-group">
						<li style="display:none;" class="list-group-item">
							<a href="EditRebuild.aspx">Edit Rebuild Details</a>
						</li>
						<li class="list-group-item">
							<asp:HyperLink ID="hypRebuildProgressUpdates" runat="server" Text="Update Progress"></asp:HyperLink>
						</li>
						<li style="display:none;" class="list-group-item">
							<span class="badge badge-success">10</span>
							Case Notes
						</li>
						<li style="display:none;" class="list-group-item ">
							<span class="badge badge-info">12</span>
							Collaborators
						</li>
						<li style="display:none;" class="list-group-item">
							<span class="badge badge-primary">16</span>
							Household Items
						</li>
						<li style="display:none;" class="list-group-item">
							<span class="badge badge-danger">10</span>
							Photos
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<div class="hpanel">

				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#tab-1">Posts</a></li>
					<li class=""><a data-toggle="tab" href="#tab-2">Work Tasks</a></li>
				</ul>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane active">
						<div class="panel-body no-padding">
							<div class="chat-discussion" style="height: auto">
								<div class="chat-message">
									<asp:Image ID="imgNewPostLogo" runat="server" CssClass="post-logo" />
									<div class="message">
										<a class="message-author" href="#">  </a>
										<span class="message-date"> Mon Jan 26 2015 - 18:39:23 </span>
										<span class="message-content">
											<asp:TextBox TextMode="MultiLine" CssClass="form-control" ID="txtPost" runat="server"></asp:TextBox>
										</span>
										<div style="overflow:auto;">
											<asp:Button ID="btnRebuildPost" OnClick="btnRebuildPost_Click" CssClass="btn w-xs btn-sm btn-primary pull-right m-t-sm" runat="server" Text="Post" />
										</div>
									</div>
								</div>
								<asp:Repeater ID="rptPosts" runat="server">
									<ItemTemplate>
										<div class="chat-message">
											<img class="post-logo" src='<%# DataBinder.Eval(Container.DataItem, "Logo") %>'>
											<div class="message">
												<a class="message-author" href='/Account/User/Profile.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ProfileId") %>'> <%# DataBinder.Eval(Container.DataItem, "fullname") %> </a>
												<span class="message-date"> <%# DataBinder.Eval(Container.DataItem, "createdon", "{0:M/d/yyyy HH:mm:ss}") %> </span>
												<span class="message-content">
												<%# DataBinder.Eval(Container.DataItem, "Post") %>
												</span>
											</div>
										</div>
									</ItemTemplate>
								</asp:Repeater>
							</div>
						</div>
					</div>
					<div id="tab-2" class="tab-pane">
						<div class="panel-body">
							<strong>Lorem ipsum dolor sit amet, consectetuer adipiscing</strong>

							<p>A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of
								existence in this spot, which was created for the bliss of souls like mine.</p>

							<div class="table-responsive">
								<table class="table table-striped">
									<thead>
									<tr>

										<th>#</th>
										<th>Project </th>
										<th>Name </th>
										<th>Phone </th>
										<th>Company </th>
										<th>Completed </th>
										<th>Task</th>
										<th>Date</th>
										<th>Action</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td>1</td>
										<td>Project <small>This is example of project</small></td>
										<td>Patrick Smith</td>
										<td>0800 051213</td>
										<td>Inceptos Hymenaeos Ltd</td>
										<td><span class="pie">2/45</span></td>
										<td>20%</td>
										<td>Jul 14, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>2</td>
										<td>Alpha project</td>
										<td>Alice Jackson</td>
										<td>0500 780909</td>
										<td>Nec Euismod In Company</td>
										<td><span class="pie">1/5</span></td>
										<td>40%</td>
										<td>Jul 16, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>3</td>
										<td>Betha project</td>
										<td>John Smith</td>
										<td>0800 1111</td>
										<td>Erat Volutpat</td>
										<td><span class="pie">4/7</span></td>
										<td>75%</td>
										<td>Jul 18, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>4</td>
										<td>Gamma project</td>
										<td>Anna Jordan</td>
										<td>(016977) 0648</td>
										<td>Tellus Ltd</td>
										<td><span class="pie">12/3</span></td>
										<td>18%</td>
										<td>Jul 22, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>2</td>
										<td>Alpha project</td>
										<td>Alice Jackson</td>
										<td>0500 780909</td>
										<td>Nec Euismod In Company</td>
										<td><span class="pie">2/5</span></td>
										<td>40%</td>
										<td>Jul 16, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>1</td>
										<td>Project <small>This is example of project</small></td>
										<td>Patrick Smith</td>
										<td>0800 051213</td>
										<td>Inceptos Hymenaeos Ltd</td>
										<td><span class="pie">1/5</span></td>
										<td>20%</td>
										<td>Jul 14, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>4</td>
										<td>Gamma project</td>
										<td>Anna Jordan</td>
										<td>(016977) 0648</td>
										<td>Tellus Ltd</td>
										<td><span class="pie">2/8</span></td>
										<td>18%</td>
										<td>Jul 22, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>1</td>
										<td>Project <small>This is example of project</small></td>
										<td>Patrick Smith</td>
										<td>0800 051213</td>
										<td>Inceptos Hymenaeos Ltd</td>
										<td><span class="pie">15/5</span></td>
										<td>20%</td>
										<td>Jul 14, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>2</td>
										<td>Alpha project</td>
										<td>Alice Jackson</td>
										<td>0500 780909</td>
										<td>Nec Euismod In Company</td>
										<td><span class="pie">2/3</span></td>
										<td>40%</td>
										<td>Jul 16, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>3</td>
										<td>Betha project</td>
										<td>John Smith</td>
										<td>0800 1111</td>
										<td>Erat Volutpat</td>
										<td><span class="pie">4/5</span></td>
										<td>75%</td>
										<td>Jul 18, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>4</td>
										<td>Gamma project</td>
										<td>Anna Jordan</td>
										<td>(016977) 0648</td>
										<td>Tellus Ltd</td>
										<td><span class="pie">2/12</span></td>
										<td>18%</td>
										<td>Jul 22, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>2</td>
										<td>Alpha project</td>
										<td>Alice Jackson</td>
										<td>0500 780909</td>
										<td>Nec Euismod In Company</td>
										<td><span class="pie">2/3</span></td>
										<td>40%</td>
										<td>Jul 16, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>1</td>
										<td>Project <small>This is example of project</small></td>
										<td>Patrick Smith</td>
										<td>0800 051213</td>
										<td>Inceptos Hymenaeos Ltd</td>
										<td><span class="pie">1/5</span></td>
										<td>20%</td>
										<td>Jul 14, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									<tr>
										<td>4</td>
										<td>Gamma project</td>
										<td>Anna Jordan</td>
										<td>(016977) 0648</td>
										<td>Tellus Ltd</td>
										<td><span class="pie">10/50</span></td>
										<td>18%</td>
										<td>Jul 22, 2013</td>
										<td><a href="#"><i class="fa fa-check text-success"></i></a></td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-6">
			<div class="hpanel">
				<div class="panel-heading">
					Etta's Rebuild Progress
				</div>
				<div class="panel-body">
					<div>
						<canvas id="lineOptionsRebuild" height="140"></canvas>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-6">
			<div class="hpanel">
				<div class="panel-heading">
					Overall Progress
				</div>
				<div class="panel-body">
					<div>
						<canvas id="lineOptionsOverall" height="140"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	</div>
</div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CrowdRelief._Default" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script src="Scripts/masonry.pkgd.min.js"></script>
	<script src="Scripts/jquery.AshAlom.gaugeMeter-2.0.0.min.js"></script>

	<script>
		$(document).ready(function () {
			$('.grid').masonry({
				itemSelector: '.grid-item', // use a separate class for itemSelector, other than .col-
				columnWidth: '.grid-sizer',
				gutter: 10
			});

			$(".btnsendsupplies").click(function () {
				location.href = "https://crowdrelief-forms.nogginoca.com/donate.html";
			});

			$(".btnrequestsupplies").click(function () {
				location.href = "https://crowdrelief-forms.nogginoca.com/supplies.html";
			});
			
			$(".btndonate").click(function () {
				location.href = "http://www.CajunRelief.org/Donate";
			});

			$(".btnrescue").click(function () {
				location.href = "https://crowdrelief-forms.nogginoca.com/rescue.html";
			});

			$(".grid-item").click(function () {
				var campaignId = $( this ).attr( "campaignId" )
            	location.href = "/Campaign.aspx?campaignId=" + campaignId;
			});

			$(".GaugeMeter").gaugeMeter();

		});
	</script>
	<style>
		.grid-item {
		 display: inline-block;
		 padding:  .25rem;
		 width:300px;
		 min-height:380px;
		 margin-bottom:10px;
		 cursor: pointer;
		}
		.grid-item:hover {
			background-color:#CCCCCC;
		}
		.grid-sizer { width: 300px; }
		.grid-photo
		{
			margin-bottom:10px;
		}
		.grid-content
		{
			text-align:left;
			margin:10px;
			margin-top:20px;

			color:white;
			display: block;
			display: -webkit-box;
			max-width: 400px;
			height: 120px;
			line-height: 1.2;
			-webkit-line-clamp: 3;
			-webkit-box-orient: vertical;
			overflow: hidden;
			text-overflow: ellipsis;
		}
		.GaugeMeter {
			margin-top:-86px;
			margin-left:220px;
			font-weight:bold;
			position:absolute;
			z-index:11;
			color:#00FF00;
		}
		.row{
			padding:0px;
			margin:0px;
		}

		.bg-black{
			background-color:#020202;
			margin-top:-15px;
		}

		.GaugeMeter SPAN, .GaugeMeter B {
			width: 54%;
			position: Absolute;
			text-align: Center;
			display: Inline-Block;
			color:#00FF00;
			font-weight:bold;
			font-family: "Open Sans", Arial;
			overflow: Hidden;
			white-space: NoWrap;
			text-overflow: Ellipsis;
			margin: 0 23%;
			font-size:1.0em;
		}

		.GaugeMeter[data-style="Semi"] B {
			width: 80%;
			margin: 0 10%;
			font-size: 1.0em;
			color:white;
			font-weight:bold;
		}

		.GaugeMeter S, .GaugeMeter U {
			text-decoration: None;
			font-size: 1.0em;
			font-weight:bold;
			opacity: .9;
			color:white;
		}

		.GaugeMeter B {
			color: #000;
			font-size: 1.0em;
			font-weight:bold;
			opacity: .9;
			color:white;
		}

		.CampaignData
		{
			margin-top:-60px;
			font-weight:bold;
			margin-left:-10px;
			position:absolute;
			z-index:10;
			display:block;
			width:295px;
			padding:10px;
			background: -moz-linear-gradient(top,  rgba(0,0,0,0) 0%, rgba(0,0,0,0.64) 66%, rgba(0,0,0,0.64) 100%); /* FF3.6-15 */
			background: -webkit-linear-gradient(top,  rgba(0,0,0,0) 0%,rgba(0,0,0,0.64) 66%,rgba(0,0,0,0.64) 100%); /* Chrome10-25,Safari5.1-6 */
			background: linear-gradient(to bottom,  rgba(0,0,0,0) 0%,rgba(0,0,0,0.64) 66%,rgba(0,0,0,0.64) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
			filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00000000', endColorstr='#a3000000',GradientType=0 ); /* IE6-9 */

		}

		.margin-top-50
		{
			margin:0px;
			margin-top:30px;
		}
	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!-- First Container -->
	
	<div class="container-fluid-1 bg-1 text-center" runat="server" visible="true">
		<div class="row row-1">
			<div class="col-lg-2"></div>
			<div class="col-xs-12 col-lg-4">
				<h1>Hurricane Irma<br />CrowdRelief Resource Page</h1>
				This is a once in a lifetime opportunity to serve your fellow Americans. We welcome you to join us to help those affected by Hurricane Irma.
				<br />
				
				<br /><br />
				Delivering supplies?
				Use <a href="https://www.glympse.com/!irma" target="_blank">Glympse Map</a> and their APP.<br />Glympse tag <b>!IRMA</b>. It has road conditions so we can track you.
				<br />
				Exchange stories & photos in <a href="https://www.facebook.com/groups/irmamemoirs" target="_blank">IRMA Memoirs Facebook Group</a>.
				<br /><br />
				<button type="button" class="btn btn-danger btn-lg margin-top-50 btn-1 btnrescue">REQUEST A WELLNESS CHECK</button>
				<button type="button" class="btn btn-danger btn-lg margin-top-50 btnrequestsupplies">REQUEST SUPPLIES</button>
				<br />
				<button type="button" class="btn btn-info btn-lg margin-top-50 btnsendsupplies">SEND SUPPLIES</button>
				<button type="button" class="btn btn-primary btn-lg margin-top-50 btn-1">VOLUNTEER</button>
				<br />
				<button type="button" class="btn btn-success btn-lg margin-top-50 btndonate">Donate to the Cajun Relief Foundation</button>
				<br />
				
				<br />
				<br />Zello channel: <b>Hurricane Irma - CrowdRelief Supplies</b>
				<br /><a href="https://www.glympse.com/!irma" target="_blank">Glympse Map - IRMA Ground Team</a>
				<br /><a href="http://crowdrelief.nogginoca.com" target="_blank">Noggin OCA Distribution Login</a>
				<br /><asp:HyperLink ID="hypFB" runat="server" Text="CrowdRelief on Facebook" Target="_blank" NavigateUrl="http://www.facebook.com/CrowdRelief"></asp:HyperLink>
			</div>
			<div class="col-xs-12 col-lg-4">
				<button type="button" class="btn btn-primary btn-lg margin-top-50 btn-1">VOLUNTEER</button>
				<img src="Images/TEAM-TIGER.png" class="img-responsive" style="display:inline; padding:10px; padding-top:50px;" alt="Believe">
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>

	<!--
	<div class="container-fluid-2 bg-1 text-center center-block">
		<div class="row">
			<div class="col-xs-12">
				<div class="margin center-block">
					<h1>Donate to a Louisiana flood victim</h1>
					Help a Louisiana flood victim get back into a home of their own by donating a much needed item below.
					<br />
					Each campaign has been carefully vetted by a citizen volunteer.
				</div>
				<div class="grid">
					<div class="grid-sizer"></div>
					<asp:Repeater ID="dlCampaigns" runat="server"  OnItemDataBound="dlCampaigns_ItemDataBound">
						<ItemTemplate>
							<div class="grid-item center-block" id="divGridClick" runat="server">
									<div class="grid-item-inner" id="divGridItemInner" runat="server">
										<div id="divGridItemPhoto" runat="server" class="grid-photo"></div>
										<div id="divGridItemContent" runat="server" class="grid-content">
											<div class="CampaignGauge">
												<asp:Literal ID="litGaugeSVG" runat="server"></asp:Literal>
											</div>
											<div class="CampaignData">
												<asp:Label id="lblCount" runat="server"></asp:Label><br />
												<asp:Label id="lblCost" runat="server" Visible="false"></asp:Label>
											</div>
											<asp:Label id="lblCampaignTitle" CssClass="CampaignTitleMasonry" runat="server"></asp:Label>
											<div class="CampaignDescriptionMasonry">
												<p>
													<asp:Label id="lblCampaignDescription" runat="server"></asp:Label>
												</p>
											</div>
										</div>
									</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
		</div>
	</div>
		-->
	
<!-- Third Container -->
</asp:Content>
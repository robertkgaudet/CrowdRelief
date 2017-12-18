<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Campaigns.aspx.cs" Inherits="CrowdRelief.Campaigns" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script src="Scripts/jquery.AshAlom.gaugeMeter-2.0.0.min.js"></script>

	<script src="Scripts/masonry.pkgd.min.js"></script>
	<script>
		$(document).ready(function () {
			$('.grid').masonry({
				itemSelector: '.grid-item', // use a separate class for itemSelector, other than .col-
				columnWidth: '.grid-sizer',
				gutter: 10
			});

			$(".grid-item").click(function () {
				var campaignId = $( this ).attr( "campaignId" )
            	location.href = "/Campaign.aspx?campaignId=" + campaignId;
			});

			$(".GaugeMeter").gaugeMeter();

<%--			var gaugeConfig = liquidFillGaugeDefaultSettings();
			gaugeConfig.circleThickness = 0.25;
			gaugeConfig.circleFillGap = 0.05;
			gaugeConfig.circleColor = "#FFFC19";
			gaugeConfig.textColor = "#ffffff";
			gaugeConfig.waveTextColor = "#5E5E5E";
			gaugeConfig.waveColor = "#44A1F2";
			gaugeConfig.textVertPosition = 0.5;
			gaugeConfig.waveAnimateTime = 2000;
			gaugeConfig.waveHeight = 0.07;
			gaugeConfig.waveAnimate = true;
			gaugeConfig.waveRise = true;
			gaugeConfig.waveHeightScaling = false;
			gaugeConfig.waveOffset = 0.25;
			gaugeConfig.textSize = 1.10;
			gaugeConfig.waveCount = 2;
			<%=gaugeScript%>--%>
		});
</script>


	<style>

        .liquidFillGaugeText { font-family: Helvetica; font-weight: bold; }

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
			color:white;
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
			height: 125px;
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
		  font-size:1.0em;
		color:white;
		  font-weight:bold;
		}

		.GaugeMeter S, .GaugeMeter U {
		  text-decoration: None;
		  font-size:1.0em;
		  font-weight:bold;
		  opacity: .9;
			color:white;
		}

		.GaugeMeter B {
		  color: #000;
		  font-size:1.0em;
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
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<!-- Second Container (Grid) -->
	<div class="container-fluid text-left">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-xs-12 col-sm-8">
				<h1>Give to a Louisiana flood victim</h1>
				Help a Louisiana flood victim get back into a home of their own by donating a much needed item below.
				<br />
				Each campaign has been carefully vetted by a citizen volunteer.
				<!--masonry here-->
				<div class="grid">
					<div class="grid-sizer"></div>
					<asp:Repeater ID="dlCampaigns" runat="server"  OnItemDataBound="dlCampaigns_ItemDataBound">
						<ItemTemplate>
							<div class="grid-item" id="divGridClick" runat="server">
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
			<div class="col-sm-2"></div>
		</div>
	</div>
</asp:Content>


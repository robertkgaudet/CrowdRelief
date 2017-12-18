<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Campaigns.ascx.cs" Inherits="CrowdRelief.Account_UserControls_Campaigns" %>

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
		});
	</script>


	<style>

		.container-fluid
		{
			margin-top:100px;
		}
		
		.CampaignTitleMasonry
		{
			font-family: 'Passion One', cursive;
			font-size:20px;
			color:black;
		}
		.CampaignDescriptionMasonry
		{
			display:block;
			padding-top:20px;
			color:black;
		}

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

	<div class="container-fluid">
			<div class="hpanel hblue">
				<div class="panel-body">
						<div class="row">
							<div class="pull-left" runat="server" id="divCampaignInfoPanel" visible="false">
								<asp:HyperLink ID="hypImageOrganization" Target="_blank" runat="server"><asp:Image runat="server" Height="200" id="imgOrganization" CssClass="m-l-lg  img-responsive img-rounded"></asp:Image></asp:HyperLink><br />
								<div class="d-block m-r-sm">
									<small>These Families are Sponsored by: <asp:HyperLink ID="hypOrganization" Target="_blank" runat="server"></asp:HyperLink></small>
								</div>
							</div>
							<div class="m-l-md">
								<h2 class="font-light m-b-xs">
									Donate to Help At-Risk Flood Stricken Families
								</h2>
								<small>Help a Louisiana flood victim get back into a home of their own by donating a much needed item below.
								<br />
								Each campaign has been carefully vetted by a citizen volunteer.</small>
								<div class="d-inline-block">
									<h4>Filter by Sponsoring Organizations</h4>
									<asp:DataList RepeatLayout="Flow" RepeatDirection="Horizontal" ID="dlPartners" runat="server" OnItemDataBound="dlPartners_ItemDataBound">
										<ItemTemplate>
											<asp:HyperLink ID="hypPartners" runat="server">
											<asp:Image ID="imgPartners" runat="server" CssClass="img-thumbnail img-small" />
											</asp:HyperLink>
										</ItemTemplate>
									</asp:DataList>
								</div>
							</div>
							<div id="hbreadcrumb" class="pull-right m-t-lg">
								<ol class="hbreadcrumb breadcrumb">
									<li><a href="/Default.aspx">Home</a></li>
									<li><a href="/NonProfitCampaigns.aspx">View All Campaigns</a></li>
									<li class="active"><asp:Label ID="lblCurrentOrganization" runat="server"></asp:Label> </li>
								</ol>
							</div>
						</div>
				</div>
			</div>

		<div class="row">
			<div class="col-xs-12">
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
		</div>
	</div>
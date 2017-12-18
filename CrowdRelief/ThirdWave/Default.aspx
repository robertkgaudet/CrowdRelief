<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CrowdRelief._Default" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script src="/Scripts/masonry.pkgd.min.js"></script>
	<script src="/Scripts/jquery.AshAlom.gaugeMeter-2.0.0.min.js"></script>

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

			$(".btndonatemoney").click(function () {
				location.href = "https://www.globalempowermentmission.org/d-o-n-a-t-e";
			});
			
			$(".btnrequestsupplies").click(function () {
				location.href = "https://crowdrelief-forms.nogginoca.com/supplies.html";
			});
			
			$(".btndonate").click(function () {
				location.href = "https://docs.google.com/forms/d/e/1FAIpQLSefZhlmNYl5X0gvlOO_YaMHSehID93HdJ_uVnkws1l4kHxtmA/viewform";
			});
			$(".btnvolunteer").click(function () {
				location.href = "https://docs.google.com/forms/d/e/1FAIpQLSeac7WymljGTM5ikzU5GFdZBz79vf4wPGL_sm1VUK4EOvHK3Q/viewform";
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
			<div class="col-xs-12 col-lg-8">
				<img src="../Images/bstrongglobalbetter.png" />
			   <br>
				- Everyone's Needed -
                <br>
                <br>
				We welcome you to join us to help those affected by Hurricane Harvey, Irma and Maria.
                <br>
				<br>
                <a id="ContentPlaceHolder1_hypWebsite" href="http://www.thirdwavevolunteers.com/" target="_blank">Third Wave Website</a>
                <br>
                <a id="ContentPlaceHolder1_hypFB" href="http://www.facebook.com/groups/Thethirdwavevolunteers/" target="_blank">Third Wave Volunteers on Facebook</a>
                <br>
				<br>
				<button type="button" class="btn btn-warning btn-lg margin-top-50 btnrequestsupplies">REQUEST SUPPLIES</button> 
				<br />
				<button type="button" class="btn btn-success btn-lg margin-top-50 btndonatemoney">DONATE to BStrongGlobalBetter</button> <button type="button" class="btn btn-success btn-lg margin-top-50 btnvolunteer">VOLUNTEER</button>
				<br />
				<button type="button" class="btn btn-info btn-lg margin-top-50 btnsendsupplies">DONATE SUPPLIES</button>
				<button type="button" class="btn btn-info btn-lg margin-top-50 btndonate">DONATE TRANSPORTATION</button>
				<br />
				
				<br />
				
				<br />
				
				<a href="http://crowdrelief.nogginoca.com/" target="_blank">Noggin OCA Distribution Login</a>
				 <br><br><br>

                <small>*Disclaimer:  We do not designate donations for individuals or organizations. Supplies are dispersed at our discretion and delivered to the areas with the greatest need.</small>
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
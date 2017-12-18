<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DefaultCarosel.aspx.cs" Inherits="CrowdRelief._DefaultCarosel" %>
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

			$(".grid-item").click(function () {
				var campaignId = $( this ).attr( "campaignId" )
            	location.href = "/Campaign.aspx?campaignId=" + campaignId;
			});

			$(".GaugeMeter").gaugeMeter();

			$('#myCarousel').hover(function () {
				$(this).carousel('pause')
			}, function () {
				$(this).carousel('cycle')
			})

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
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!-- First Container -->
	<div class="container-fluid-1 bg-1 text-center" runat="server" visible="false">
		<div class="row row-1">
			<div class="col-lg-2"></div>
			<div class="col-xs-12 col-lg-4">
				<img src="Images/Louisiana-Neighbors-Helping.png" class="img-responsive margin img-1" height="105" width="700" />
				CrowdRelief is a web application <br/> for finding and meeting <br/> the most urgent needs <br/> of Louisiana flood victims. 
				<br /><br />
				Let's work together <br/> to help those who are unable <br/> to help themselves.
				<br />
				<button type="button" class="btn btn-primary btn-danger btn-lg btn-1 margin-top-50">Request Help</button>
			</div>
			<div class="col-xs-12 col-lg-4">
				<img src="Images/HeartHandsWomanBlonde.png" class="img-responsive" style="display:inline; padding-left: 10px; padding-right:10px" alt="Believe" width="443" height="500">
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>

	<div class="container-fluid-2 bg-black text-center center-block">
		<div class="row">
			<div class="col-sm-1"></div>
			<div class="col-xs-12 col-sm-10">
				<div id="myCarousel" class="carousel slide" data-ride="carousel" data-pause="hover"  data-interval="3000">
					<!-- Indicators -->
					<ol class="carousel-indicators">
					  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					  <li data-target="#myCarousel" data-slide-to="1"></li>
					  <li data-target="#myCarousel" data-slide-to="2"></li>
					  <li data-target="#myCarousel" data-slide-to="3"></li>
					  <li data-target="#myCarousel" data-slide-to="4"></li>
					  <li data-target="#myCarousel" data-slide-to="5"></li>
					  <li data-target="#myCarousel" data-slide-to="6"></li>
					  <li data-target="#myCarousel" data-slide-to="7"></li>
					  <li data-target="#myCarousel" data-slide-to="8"></li>
					</ol>
					
					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
    
					  <div class="item active">
						<img src="Images/w-1.jpg" width="1400" height="817">
					  </div>

					  <div class="item">
						<img src="Images/w-2.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-3.jpg" width="1400" height="817">
					  </div>

					  <div class="item">
						<img src="Images/w-8.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-4.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-5.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-6.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-7.jpg" width="1400" height="817">
					  </div>
    
					  <div class="item">
						<img src="Images/w-9.jpg" width="1400" height="817">
					  </div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
					  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					  <span class="sr-only">Previous</span>
					</a>
					<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
					  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					  <span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<div class="col-sm-1"></div>
		</div>
	</div>

	<div class="container-fluid-2 bg-1 text-center center-block">
		<div class="row">
			<div class="col-xs-12">
				<div class="margin center-block">
					<h1>Donate to a Louisiana flood victim</h1>
					Help a Louisiana flood victim get back into a home of their own by donating a much needed item below.
					<br />
					Each campaign has been carefully vetted by a citizen volunteer.
				</div>
				<!--masonry here-->
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
	
<!-- Third Container -->
	<div class="container-fluid bg-2">
		<div class="col-md-2"></div>
		<div class="well col-xs-12 col-md-8 center-block" style="color:#555555">
			<h1 class="margin">Flood Victims </h1>
			<h3>Call 225–289–3950 to request a household needs survey</h3>
			<p>
				CrowdRelief helps by creating a crowdfunding campaign to help you repurchase some of the household items lost in the Louisiana Flood. <a href="About.aspx"> Read more about us and how crowdfunding works here.</a>
			</p>
			<p>
				The call center hours of operation are <br />
				<ul>
					<li>Monday through Friday 9am to 3pm</li>
					<li>Saturday 9am to Noon</li>
				</ul>
			</p>
			<p>
				You can call 225–289–3950 to have a household needs survey completed.
			</p>
		</div>
		<div class="col-md-2"></div>
	</div>
</asp:Content>
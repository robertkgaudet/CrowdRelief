<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="Campaign.aspx.cs" Inherits="CrowdRelief.Campaign" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script src="Scripts/jquery.AshAlom.gaugeMeter-2.0.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="Scripts/slick/slick.css"/>
	<link rel="stylesheet" type="text/css" href="Scripts/slick/slick-theme.css"/>
	<script type="text/javascript" src="Scripts/slick/slick.min.js"></script>

		<script type="text/javascript">
        
			$(document).ready(function ()
			{
				$(".btn-img").click(function () {
            		location.href = "/Account/BasicNeedsSurveyCampaignPhoto.aspx?surveyId=<%=surveyId%>";
				});

				$(".GaugeMeter").gaugeMeter();



				$('.slider-for').slick({
					slidesToShow: 1,
					slidesToScroll: 1,
					arrows: false,
					fade: true,
					asNavFor: '.slider-nav'
				});
				$('.slider-nav').slick({
					slidesToShow: 3,
					slidesToScroll: 1,
					asNavFor: '.slider-for',
					dots: true,
					centerMode: true,
					focusOnSelect: true,
					autoplay: true,
					dots: false,
					pauseOnHover: true
				});
			});
		</script>
	<style>
		.donatedRow{background-color:#F8EDDA; color:darkgray;}
		.row{padding:3px;}
		.container-fluid{margin:0px;}
		.well-donate{padding:2px;}
		.margin-20{margin:20px;}
		.col-xs-2-margin-2{padding-left:2px;}

		.caption
		{
			font-size:13px;
			color:white;
			z-index:10;
			position:absolute;
			display:block;
			width:99%;
			background: -moz-linear-gradient(bottom,  rgba(0,0,0,0) 0%, rgba(0,0,0,0.64) 66%, rgba(0,0,0,0.64) 100%); /* FF3.6-15 */
			background: -webkit-linear-gradient(bottom,  rgba(0,0,0,0) 0%,rgba(0,0,0,0.64) 66%,rgba(0,0,0,0.64) 100%); /* Chrome10-25,Safari5.1-6 */
			background: linear-gradient(to top,  rgba(0,0,0,0) 0%,rgba(0,0,0,0.64) 66%,rgba(0,0,0,0.64) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
			filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#00000000', endColorstr='#a3000000',GradientType=0 ); /* IE6-9 */
		}
		
		.GaugeMeter {
			font-weight:bold;
			position:absolute;
			z-index:11;
		}

		.GaugeMeter SPAN, .GaugeMeter B {
		  width: 54%;
		  position: Absolute;
		  text-align: Center;
		  display: Inline-Block;
			color:#66CC66;
		  font-weight:bolder;
		  font-family: "Open Sans", Arial;
		  overflow: Hidden;
		  white-space: NoWrap;
		  text-overflow: Ellipsis;
		  margin: 0 23%;
		}

		.GaugeMeter[data-style="Semi"] B {
		  width: 110%;
		  margin: 0 10%;
		  font-size:2.0em;
		  font-weight:bolder;
		}

		.GaugeMeter S, .GaugeMeter U {
		  text-decoration: None;
		  font-size:2.0em;
		  font-weight:bolder;
		  opacity: .9;
		}

		.GaugeMeter B {
		  color: #000;
		  font-size:2.0em;
		  font-weight:bolder;
		  opacity: .9;
		}

		.GaugeCampaign
		{
			display:inline-block;
			overflow:auto;
		}
		.CampaignDisplay
		{
			float:left;
			display:inline-block;
		}

	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-2"></div>
		<div class="col-xs-12 col-lg-8">
			<h1>Donate to a Louisiana flood victim</h1>
					Help a Louisiana flood victim get back into a home of their own by donating a much needed item below.
					<br />
					Each campaign has been carefully vetted by a citizen volunteer.
			<div class="row">
				<div class="col-xs-12 col-sm-6 center-block pull-right">
					<div class="well well-donate">
						<div style="overflow:auto;">
							<div class="GaugeCampaign">
								<asp:Literal ID="litGauge" runat="server"></asp:Literal>
							</div>
							<div class="margin-20 CampaignDisplay">
								<h1><asp:Label ID="lblName" runat="server"></asp:Label></h1>
								<br />
								<asp:Label CssClass="OpenNeedAmt" ID="lblAmountNeeded" runat="server"></asp:Label> <asp:Literal id="litTotalNeeded" runat="server"></asp:Literal>
								<asp:Literal id="litDonatedAmount" runat="server" Visible="false"></asp:Literal>
							</div>
						</div>
						<div style="display:block; overflow:auto;">
							<div class="container-fluid">
								<asp:DataList RepeatDirection="Vertical" RepeatLayout="Flow" runat="server" ID="dlItemsNeeded" OnItemDataBound="dlItemsNeeded_ItemDataBound">
									<ItemTemplate>
										<div id="rowDonate" runat="server">
											<div class="col-xs-2 col-xs-2-margin-2">
												<asp:Button ID="btnDonate" OnClick="btnDonate_Click" runat="server" Text="Donate" />
											</div>
											<div class="col-xs-8 pull-right">
												<asp:Label ID="lblItem" runat="server"></asp:Label>
											</div>
											<div class="col-xs-1">
												<asp:Label ID="lblCost" runat="server"></asp:Label>
											</div>
										</div>
									</ItemTemplate>
								</asp:DataList>
							</div>
						</div>
					</div>
					<div class="fb-comments" data-href="<%=pageURL%>" data-numposts="10"></div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="slider slider-for" runat="server" id="divSlidersFor">
						<asp:Repeater ID="dlPhotosfor" runat="server" OnItemDataBound="dlPhotos_ItemDataBound">
							<ItemTemplate>
								<div class="thumbnail">
									<div class="caption" runat="server">
										<strong><asp:Label ID="lblTitle" runat="server" ForeColor="White" Font-Size="10"></asp:Label></strong>
										<p><asp:Label ID="lblDescription" runat="server" ForeColor="White" Font-Size="10"></asp:Label> </p>
									</div>
									<asp:Image ID="imgPhoto" runat="server" CssClass="img-responsive" Width="100%" />
								</div>
							</ItemTemplate>
						</asp:Repeater>
					</div>
					<div class="slider slider-nav" runat="server" id="divSlidersCarosell">
						<asp:Repeater ID="dlPhotos" runat="server" OnItemDataBound="dlPhotos_ItemDataBound">
							<ItemTemplate>
									<asp:Image ID="imgPhoto" runat="server" CssClass="img-thumbnail" />
									<div class="caption" runat="server" visible="false">
										<strong><asp:Label ID="lblTitle" runat="server"></asp:Label></strong>
										<p><asp:Label ID="lblDescription" runat="server"></asp:Label> </p>
									</div>
							</ItemTemplate>
						</asp:Repeater>
					</div>
					<asp:Image ID="imgCampaignPhoto" CssClass="img-responsive img-rounded margin" runat="server" />
					<div class="well text-center" runat="server" id="divCampaignImageButton" visible="false">
						<p>
						<asp:Label ID="lblAddImage" runat="server" Text="Adding a campaign image can help increase donation amounts." Visible="false"></asp:Label>
						</p>
						<asp:HyperLink ID="btnAddImage" runat="server" CssClass="btn btn-primary btn-lg btn-img lcikc" Text="Add a Campaign Image" Visible="false"></asp:HyperLink>
					</div>
					<div runat="server" id="divAdminPanel" class="well">
						<strong>Administrator</strong><br />
						<asp:HyperLink ID="hypViewSurvey" runat="server" Text="View Survey"></asp:HyperLink> | <asp:HyperLink ID="hypAddImages" runat="server" Text="Manage Photos"></asp:HyperLink> | <asp:HyperLink ID="hypEmbedVideo" runat="server" Text="Embed Video"></asp:HyperLink>
					</div>
					<div class="well" runat="server" id="divVideoEmbed">
						<asp:Literal ID="litVideoEmbed" runat="server"></asp:Literal>
					</div>
					<div class="well">
						<h1 style="margin-top:0px;"><asp:Literal ID="litCampaignName" runat="server"></asp:Literal> </h1>
						<asp:Label ID="lblCampaignDescription" runat="server"></asp:Label>
						<asp:Label ID="lblStory" runat="server" Visible="false"></asp:Label><br />
						<div style="display:block; margin-top:5px; overflow:auto;">
							<asp:HyperLink ID="hypImageOrganization" Target="_blank" runat="server"><asp:Image runat="server" id="imgOrganization" width="100" CssClass="img-responsive pull-left"></asp:Image></asp:HyperLink><br />
							<small class="pull-right;">Sponsored by: <asp:HyperLink ID="hypOrganization" Target="_blank" runat="server"></asp:HyperLink></small>
						</div>
					</div>
					<div class="row" runat="server" visible="false">
						<div class="col-sm-8">
							<div class="well">
								<h4>LOSS DETAILS</h4>
								<p>
									<asp:Label ID="lblFemaNumber" runat="server" Visible="false"></asp:Label>
									<asp:Label ID="lblAddress" runat="server" Visible="false"></asp:Label>
									<asp:Label ID="lblCity" runat="server"></asp:Label>,
									<asp:Label ID="lblState" runat="server"></asp:Label>
									<asp:Label ID="lblZip" runat="server"></asp:Label>
									<asp:Label ID="lblParish" runat="server"></asp:Label>
									<br />
									<asp:Label ID="lblImmediateHousingNeeded" runat="server"></asp:Label>
									<br />
									<asp:Label ID="lblRebuildRepairNeeded" runat="server"></asp:Label>
									<br />
									<asp:Label ID="lblSupportBeingProvided" runat="server"></asp:Label>
									<br />
									<asp:Label ID="lblInHomeDuringDisaster" runat="server"></asp:Label>
									<asp:Label ID="lblPhoneNumber" runat="server" Visible="false"></asp:Label>
									<asp:Label ID="lblEmailAddress" runat="server" Visible="false"></asp:Label>
								</p>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="well">
								<p>
									<asp:Label CssClass="small" ID="lblTimeSpan" runat="server"></asp:Label> by 
									<asp:HyperLink CssClass="small" ID="hypCreatorName" runat="server"></asp:HyperLink> from 
									<asp:Label CssClass="small" ID="lblLocation" runat="server"></asp:Label>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-2">
		</div>
	</div>
</div>

<div class="container-fluid">
	<div class="col-xs-1 col-lg-2"></div>
	<div class="col-xs-10 col-lg-8">
		<asp:Label ID="lblSurveyNumber" runat="server"></asp:Label>
	</div>
	<div class="col-xs-1 col-lg-2"></div>
</div>
</asp:Content>
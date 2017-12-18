<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/Landing.master" AutoEventWireup="true" CodeFile="Landing-1.aspx.cs" Inherits="CrowdRelief.Landing_1" %>

<%@ Register Src="~/Account/UserControls/HomepageHeader.ascx" TagPrefix="uc1" TagName="HomepageHeader" %>
<%@ Register Src="~/Account/UserControls/CollaboratorImageList.ascx" TagPrefix="uc1" TagName="CollaboratorImageList" %>
<%@ Register Src="~/Account/UserControls/DisasterProjectProgressPanel.ascx" TagPrefix="uc1" TagName="DisasterProjectProgressPanel" %>
<%@ Register Src="~/Account/UserControls/ReliefStream.ascx" TagPrefix="uc1" TagName="ReliefStream" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
		<script src="/Scripts/vendor/iCheck/icheck.min.js"></script>
		<script src="/Scripts/vendor/sparkline/index.js"></script>
		<script src="/Scripts/homer.js"></script>


		
		<!-- Local script for menu handle -->
		<!-- It can be also directive -->
		<script>
			$(document).ready(function () {

				// Page scrolling feature
				$('a.page-scroll').bind('click', function(event) {
					var link = $(this);
					$('html, body').stop().animate({
						scrollTop: $(link.attr('href')).offset().top - 50
					}, 500);
					event.preventDefault();
				});

				$('body').scrollspy({
					target: '.navbar-fixed-top',
					offset: 80
				});

			});
		</script>
	<style>
		.heading-image
		{
			width:400px;
		}
		#page-top
		{
			background-image:none;
			background-color:#35478C;
		}

	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">

	
<!-- Simple splash screen-->
<div class="splash"> <div class="color-line"></div><div class="splash-title"><h1>Homer - Responsive Admin Theme</h1><p>Special Admin Theme for small and medium webapp with very clean and aesthetic style and feel. </p><div class="spinner"> <div class="rect1"></div> <div class="rect2"></div> <div class="rect3"></div> <div class="rect4"></div> <div class="rect5"></div> </div> </div> </div>
<!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->
	
<uc1:HomepageHeader runat="server" ID="HomepageHeader" />
	
<header id="page-top">
    <div class="container">
		<div class="row">
			<div class="col-sm-6">
				<div class="heading-image panel center-block m-t-lg">
					<div class="form-horizontal">
						<h2>Join The Crowd</h2>
						Believe, Innovate, Inspire
						<div id="divError" runat="server" visible="false" style="color:red; font-weight:bold; font-size:x-small;"><asp:Literal id="litError" runat="server"></asp:Literal> </div>
					 
						<!-- Text input-->
						<div class="form-group">
							<label class="control-label pull-left" for="txtFirstname">First Name</label>  
							<div>
								<asp:TextBox ID="txtFirstName" name="txtFirstName" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
							</div>
						</div>

					

						<!-- Text input-->
						<div class="form-group">
							<label class="control-label pull-left" for="txtFirstname">Last Name</label>  
							<div>
								<asp:TextBox ID="txtLastName" name="txtLastName" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
							</div>
						</div>

					
						<!-- Text input-->
						<div class="form-group">
							<label class="control-label pull-left" for="txtFirstname">Email Address</label>  
							<div>
								<asp:TextBox ID="txtEmail" name="txtEmail" runat="server" placeholder="" class="form-control input-md" required=""></asp:TextBox>
							</div>
						</div>

					
						<!-- Text input-->
						<div class="form-group">
							<label class="control-label pull-left" for="txtFirstname">Password</label>  
							<div>
								<asp:TextBox ID="txtPassword" name="txtPassword" runat="server" TextMode="Password" placeholder="" class="form-control input-md" required=""></asp:TextBox>
							</div>
						</div>
					
						<!-- Text input-->
						<div class="form-group">
								<asp:Button ID="btnSubmit" runat="server" Text="Join Now" OnClick="btnSubmit_Click" CssClass="btn btn-warning btn-block" />
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="heading-image panel m-t-lg text-right" style="text-align:left;">
					<h1>About CrowdRelief</h1>We provides apps designed specifically for non-profits that measure impact and automatically share the good accomplished.
				</div>
			</div>
		</div>
    </div>
</header>
	FEED HERE
<section>
    <div class="container">
		<div class="row">
			<div class="col-md-3">
				<h4>Collaborate</h4>
				<p><strong>Many is greater than one.</strong> Collaboration has been vital for non-profits rebuilding Louisiana after floods ravaged the state in August 2016. Efficient is key. Our rebuild tools enable close collaboration between multiple non-profits driving efficiency.</p>
			</div>
			<div class="col-md-3">
				<h4>Measure</h4>
				<p><strong>Easly track progress.</strong> Develop a vision, set benchmarks and measure your success and your overall communities success. Our tools can help you demonstrate progress towards your non-profits mission.</p>
			</div>
			<div class="col-md-3">
				<h4>Publish</h4>
				<p><strong>Your results automatically published.</strong> Successes big or small are an important part of your organizations message. Communicating that message can be difficult when you're focusing on your non-profits mission.</p>
			</div>
			<div class="col-md-3">
				<h4>Grow</h4>
				<p><strong>A rising tide lifts all vessels.</strong> Find volunteers, rebuild resources and learn from other non-profits in the field. As the CrowdRelief community grows, so does your opportunity to network and engage potential partners, funders and volunteers.</p>
			</div>
		</div>
    </div>
</section>
<section class="bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
				<uc1:ReliefStream runat="server" ID="ReliefStream" />
            </div>
            <div class="col-lg-4">
				<div class="hpanel">
					<div class="panel-heading hbuilt">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-12">
									<h2><span class="text-success">Community Progress Rebuilding Louisiana </span>together</h2>
									<p>The progress data provided below is a community effort to measure the current state of the recovery while rebuilding Louisiana neighborhoods, cities and communities. It is only as good as the information in the CrowdRelief system. Help us keep it updated by continually updating any information you have access to. You can also help by sharing this site with anyone who was affected by the flood and encouraging them to enter and update their information on a regular basis.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="panel-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-xs-12">
									<h4 class="m-t-xxl">Home Rebuild Progress and Volunteer Needs</h4>
									<p>These statistics represent the current progress towards rebuilding Louisiana after the flood of August 2016. The numbers are based on information shared by non-profits regarding the stage of each home being repaird by the collective non-profits in the system.</p>
									<p><a class="navy-link btn btn-sm" href="#" role="button">Volunteer Now</a></p>
								</div>
								<div class="col-xs-12">
									LOGIN TO POST
									<uc1:DisasterProjectProgressPanel runat="server" ID="DisasterProjectProgressPanel" />
								</div>
							</div>
							<div class="row m-t-md">
								<div class="col-md-6">
									<h4 class="m-t-xl">Non-Profit Collaborators</h4>
									<p>Organizations collaborating in Louisiana to rebuild homes and meet survivors needs in the community.</p>
            						<p><a class="navy-link btn btn-sm" href="#" role="button">Non-Profits Can Join Us</a></p>
								</div>
								<div class="col-md-6">
									<uc1:CollaboratorImageList runat="server" ID="CollaboratorImageList" />
								</div>
							</div>
							<div class="row  m-t-xxxl">
								<div class="col-md-6">
									<h4 class="m-t-xxl">Work To Do</h4>
									<p>Show needed volunteers and items.</p>
								</div>
								<div class="col-md-6">
									<img src="images/landing/s1.png" class="img-responsive" />
								</div>
							</div>
							<div class="row m-t-xxxl">
								<div class="col-md-6">
									<img src="images/landing/s3.png" class="img-responsive" />
								</div>
								<div class="col-md-6">
									<h4 class="m-t-xxl">Share Campaigns</h4>
									<p>Post random campaigns here for people to share.</p>
								</div>
							</div>
						</div>
						<h3>PUT A SCROLLING FEED OF WORK HAPPENING RIGHT NOW HERE.</h3>
						<h3>PUT THE REBUILD MAP HERE</h3>

						REBUILDING LOUISIANA WITH MEASUREMENT METRICS.
						<br />Number of crowdfunding campaigns and how much has been raised.
						<br />186
					<br />surveys completed
					<br />$624,693.00
					<br />in unmet costs
					<br />3306
					<br />total items needed
						<br />Show the nonprofits
						<br />The communities progress towards completion.
						<br />The number of volunteers needed.
						<br /> Specific items needed.

					</div>
					<div class="panel-footer">

					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</asp:Content>


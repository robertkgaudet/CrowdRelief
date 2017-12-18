<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CrowdRelief.Administration_Default" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
		.margin-top-20 {
			margin:20px;
		}
		.well {
			max-width:400px;
			margin-top:20px;

		}
		.no-padding {
			padding:0px;
			margin:0px;
		}

		.well-count{
			background: rgb(22, 105, 173);
			color:white;
		}

		.no-margin
		{
			margin:0px;
			font-weight:700;
		}

		.input-group-addon {
		min-width:100px;
		text-align:right;
		}
		.login-field{
			min-width:175px;
			max-width:175px;
		}
		.margin-top-20
		{
			margin:20px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<div class="well center-block">
					<h2>Surveys</h2>
					<div class="well well-count">
						<asp:Label ID="lblSurveyCount" runat="server"></asp:Label><br />
						<asp:Label ID="lblTotalUnmetNeeds" runat="server"></asp:Label><br />
						<asp:Label ID="lblTotalItemsNeeded" runat="server"></asp:Label><br />
					</div>
					
					<h3>SEARCH</h3>
					<div class="input-group margin">
						<asp:TextBox runat="server" ID="txtTerm" type="text" class="form-control" placeholder="Enter firstname, lastname or fema number"></asp:TextBox>
						<span class="input-group-btn"><asp:Button runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click" Text="Go!" /></span>
					</div>
					<strong>
					<a href="Surveys.aspx">View All Surveys</a><br />
					<a href="UrgentNeedForHousing.aspx">View Urgent Need For Housing</a><br />
					<a href="FloodStories.aspx">View Flood Stories</a><br />
					</strong>
				</div>
				<div class="well center-block">
					<h2>Site Admin</h2>
					<a href="/Administration/Users.aspx">Users</a><br />
					<a href="/Administration/Organization.aspx">New Organization</a><br />
				</div>
			</div>
		</div>
	</div>
</asp:Content>
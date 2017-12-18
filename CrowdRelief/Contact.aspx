<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="CrowdRelief.Contact" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
		.margin-top-20
		{
			margin:20px;
		}
		.well
		{
			max-width:800px;
		}
		
		.no-padding {
		  padding:0px;
		  margin:0px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-xs-12 col-sm-8">
				<div class="well center-block">
					<p>
						<h1>Press, Media and Other Questions</h1>
					<p>
						Call Rob Gaudet at 318-572-3161 or Melissa Adair at 404-918-5299.
					</p>
					<p>
						Email us at <a href="mailto:support@crowdrelief.net">support@crowdrelief.net</a>
					</p>
					<br />
					<p>
						Write to us or visit our offices at<br />
						CrowdRelief<br />
						5557 Government Street<br />
						Baton Rouge, Louisiana 70806<br />
					</p>
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</asp:Content>


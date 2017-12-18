<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CajunReliefCommunityRedirect.aspx.cs" Inherits="CrowdRelief.CajunReliefCommunityRedirect" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
		.well
		{
			max-width:400px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-xs-12">
				<div class="center-block">
					<a href="https://www.facebook.com/groups/CajunReliefCommunity/">
						<img src="/Images/ClickToJoin.png" class="img-responsive center-block" />
					</a>
					Stay up to date with Citizen-led relief efforts. JOIN US! Collaborate with Louisiana citizens working together to help our neighbors make it through one day at a time. Join if you need help or want to use your skills to help!
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		// Your application has indicated there's an error
		window.setTimeout(function () {

			// Move to a new location or you can do something else
			window.location.href = "https://www.facebook.com/groups/CajunReliefCommunity/";

		}, 1000);

	</script>
</asp:Content>
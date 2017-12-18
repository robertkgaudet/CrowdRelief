<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EmailTest.aspx.cs" Inherits="CrowdRelief.Administration_EmailTest" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-xs-12 col-sm-6">
				<div class="center-block well">
					Send test email by pressing the button below.<br />
					<asp:TextBox ID="txtEmail" CssClass="form-control input-lg" runat="server" required="" placeholder="Enter your email address."></asp:TextBox><br />
					<asp:TextBox TextMode="MultiLine" ID="txtMessage" CssClass="form-control input-lg" runat="server" required="" placeholder="Enter your test message here."></asp:TextBox><br />
					<asp:Button ID="btnEmailTest" CssClass="btn btn-default pull-right" style="overflow:auto;" runat="server" Text="Send Test Donate Email" OnClick="btnEmailTest_Click" />
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
</asp:Content>


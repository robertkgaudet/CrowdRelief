<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Splash.aspx.cs" Inherits="CrowdRelief.Splash" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-xs-12 col-sm-8">
				<div class="center-block">
					<img src="Images/Final-Logo-Blue.png" />
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
</asp:Content>
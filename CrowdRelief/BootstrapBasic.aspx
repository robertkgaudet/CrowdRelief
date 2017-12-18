<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BootstrapBasic.aspx.cs" Inherits="CrowdRelief.BootstrapBasic" %>
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
			<div class="col-sm-3"></div>
			<div class="col-xs-12 col-sm-6">
				<div class="center-block">

				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
</asp:Content>
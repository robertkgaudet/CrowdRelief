<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/Public.master" AutoEventWireup="true" CodeFile="NonProfitCampaigns.aspx.cs" Inherits="CrowdRelief.NonProfitCampaigns" %>

<%@ Register Src="~/Account/UserControls/Campaigns.ascx" TagPrefix="uc1" TagName="Campaigns" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContentPlaceHolder1" Runat="Server">
	<div class="content animate-panel" data-child="hpanel">
		<uc1:Campaigns runat="server" ID="Campaigns" />
	</div>
</asp:Content>
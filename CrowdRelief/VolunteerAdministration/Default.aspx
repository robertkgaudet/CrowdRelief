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
					<h2>Volunteers</h2>
					<asp:Repeater ID="dlVolunteers" runat="server" OnItemDataBound="dlVolunteers_ItemDataBound">
						<ItemTemplate>
							<div class="grid-item center-block" id="divGridClick" runat="server">
								<div class="grid-item-inner" id="divGridItemInner" runat="server">
									<asp:Label ID="lblFirstname" runat="server"></asp:Label>
									<asp:Label ID="lblLastname" runat="server"></asp:Label>
									<asp:Label ID="lblPhonenumber" runat="server"></asp:Label>
								</div>
							</div>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</div>
		</div>
	</div>
</asp:Content>
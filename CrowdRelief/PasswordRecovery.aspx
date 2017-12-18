<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PasswordRecovery.aspx.cs" Inherits="CrowdRelief.PasswordRecovery" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-1 col-sm-4"></div>
			<div class="col-xs-10 col-sm-4">
				<div class="well">
				<h2>
					Password Help
				</h2>
				<p>
					Please enter your username, a new password will be emailed to you.
				</p>
					<asp:PasswordRecovery ID="prPasswordRecovery"
						runat="server"
						CssClass="GradientSilverDiagonal"
						Font-Names="Verdana"
						OnSendingMail="PasswordRecovery2_SendingMail"
						SuccessText="A temporary password has been emailed to you."
						ForeColor="#3A4F63">
					<InstructionTextStyle Font-Italic="False" />
					<SuccessTextStyle Font-Bold="True" Font-Italic="False" />
					<TitleTextStyle BackColor="#3A4F63" BorderColor="MidnightBlue" BorderStyle="Double" BorderWidth="1px" ForeColor="White" Font-Bold="True" />
					<SubmitButtonStyle BackColor="#FFFBFF" BorderColor="#3A4F63" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#3A4F63"></SubmitButtonStyle>
				</asp:PasswordRecovery>
				</div>
			</div>
			<div class="col-xs-1 col-sm-4"></div>
		</div>
	</div>
</asp:Content>
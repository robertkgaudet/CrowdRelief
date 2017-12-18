<%@ Page Title="" Language="C# " MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="CrowdRelief.Login" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
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
				<div class="well center-block login-block">
					<div class="input-group margin-top-20">
						<h2>Account Log In</h2>
						An account is required to request CrowdRelief help.<br />
						<a href="\Register.aspx?interactionType=Help">Create an account here.</a>
						<div id="divError" runat="server" visible="false" class="panel panel-danger">
						  <div class="panel-heading">Login Error Detected</div>
						  <div class="panel-body"><asp:Literal id="litError" runat="server"></asp:Literal></div>
						</div>
					</div>
					<div class="input-group margin-top-20">
						<label for="first-name" class="input-group-addon">Username</label>
						<asp:TextBox ID="txtUsername" name="txtUsername" runat="server" placeholder="" class="form-control input-md login-field" required=""></asp:TextBox>
						<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtUsername" Display="Dynamic" ErrorMessage="Cannot be empty." ForeColor="Red" Font-Size="Small" runat="server" />
					</div>
					<div class="input-group margin-top-20">
						<label for="first-name" class="input-group-addon">Password</label>
						<asp:TextBox ID="txtPassword" name="txtPassword" TextMode="Password" runat="server" placeholder="" class="form-control input-md login-field" required=""></asp:TextBox>
						<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtUsername" Display="Dynamic" ErrorMessage="Cannot be empty." ForeColor="Red" Font-Size="Small" runat="server" />
					</div>
					<div class="input-group margin-top-20">
                        <span style="font-size:14px;">
							<a href="\PasswordRecovery.aspx">Password Help</a> |
							<a href="\Register.aspx?interactionType=Help">Create Account</a>
                        </span>
					</div>
					<div class="input-group margin-top-20">
							<asp:Button ID="btnSubmit" runat="server" Text="Sign In" OnClick="btnSubmit_Click" CssClass="btn btn-primary btn-group-lg" />
					</div>
				</div>
			</div>
		</div>
	</div>
</asp:Content>
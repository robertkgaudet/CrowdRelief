<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserDetail.aspx.cs" Inherits="CrowdRelief.Administration_UserDetail" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="userDetailHeader GradientSilverHorizontal paddingFix" style="width:100%;" runat="server" id="divUser">
			<asp:Label ID="lblUsername" runat="server"></asp:Label>
		</div>
		<div class="userListDetail GradientSilverDiagonal">
			<div class="PageMessage">
				<asp:Label ID="lblPageMessage" runat="server" Text="Update user account."></asp:Label>
				<br />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hypReturnOnDelete" Visible="false" runat="server" Text="Return to User List" NavigateUrl="~/Manage/Register.aspx"></asp:HyperLink>
			</div>
			<table cellpadding="5" runat="server" id="tblUserDetail">
				<tr runat="server" id="trOrganizationMsg">
					<td colspan="2">
						Select the Organization for this user.
					</td>
				</tr>
				<tr runat="server" id="trOrganization">
					<td>
						Organization Name
						<br /><br />
					</td>
					<td>
						<asp:CheckBoxList ID="cblOrganizations" DataTextField="Name" DataValueField="OrganizationId" runat="server"></asp:CheckBoxList>
						<br /><br />
					</td>
				</tr>
				<tr>
					<td>
						Primary Organization
					</td>
					<td>
						<asp:DropDownList ID="ddlPrimaryOrg" runat="server" DataTextField="Name" DataValueField="OrganizationId">
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Full name
					</td>
					<td>
						<div style="width:250px; display:inline-block;">
							Firstname
							<br />
							<asp:TextBox runat="server" ID="txtFirstname"></asp:TextBox>
							<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ControlToValidate="txtFirstname" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
						</div>
						<div style="width:250px; display:inline-block;">
							Lastname
							<br />
							<asp:TextBox runat="server" ID="txtLastname"></asp:TextBox>
							<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="txtLastname" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						Email Address
					</td>
					<td>
						<asp:HiddenField ID="hidUserId" runat="server" />
						<asp:TextBox ID="txtEmail" Width="300" runat="server"></asp:TextBox>
						<asp:RequiredFieldValidator id="EmailRequiredValidator" runat="server" ControlToValidate="txtEmail" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
					</td>
				</tr>
				<tr>
					<td valign="top">
						<div style="margin-top:25px;">
							User Roles
						</div>
					</td>
					<td>
						<asp:CheckBoxList CellPadding="3" CssClass="CheckboxList" ID="cblRoles" runat="server" on></asp:CheckBoxList>
					</td>
				</tr>
				<tr>
					<td>
						Change Password
					</td>
					<td>
						<div style="width:200px; display:inline-block;">
							New Password
							<br />
							<asp:TextBox TextMode="Password" runat="server" ID="txtPassword"></asp:TextBox>
						</div>
						<div style="width:200px; display:inline-block;">
							Confirm Password
							<br />
							<asp:TextBox TextMode="Password" runat="server" ID="txtConfirmPassword"></asp:TextBox>
							<asp:CompareValidator id="PasswordConfirmCompareValidator" runat="server" ControlToValidate="txtConfirmPassword" ForeColor="red" Display="Dynamic" ControlToCompare="txtPassword" ErrorMessage="Confirm password must match password." />
						</div>
					</td>
				</tr>
				<tr>
					<td>
					</td>
					<td>
						<asp:CheckBox ID="chkEnableAccount" runat="server" Text="Enable User Account" />
						<div style="float:right;">
							<asp:Button ID="btnUpdate" runat="server" Text="Update User" OnClick="btnUpdate_Click" />
							<p>
								<asp:LinkButton ID="lbDeleteUser" CausesValidation="false" runat="server" OnClick="lbDeleteUser_Click" Text="Delete User Account" Visible="false"></asp:LinkButton>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						Is User Online?
					</td>
					<td>
						<asp:Label ID="lblIsUserOnline" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Date Last Logged In
					</td>
					<td>
						<asp:Label ID="lblDateLastLoggedIn" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Date of Last Activity
					</td>
					<td>
						<asp:Label ID="lblDateOfLastActivity" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Date Password Changed
					</td>
					<td>
						<asp:Label ID="lblDatePasswordChanged" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Date Account Created
					</td>
					<td>
						<asp:Label ID="lblDateAccountCreated" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Approved?
					</td>
					<td>
						<asp:Label ID="lblIsApproved" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Locked Out?
					</td>
					<td>
						<asp:Label ID="lblIsLockedOut" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						Date of Last Lockout
					</td>
					<td>
						<asp:Label ID="lblDateOfLastLockout" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td>

					</td>
					<td align="right">
						<asp:HyperLink ID="hypUserList" runat="server" Text="Return to User List" NavigateUrl="~/Administration/Users.aspx"></asp:HyperLink>
					</td>
				</tr>
			</table>
		</div>
</asp:Content>


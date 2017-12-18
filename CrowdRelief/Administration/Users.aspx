<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="CrowdRelief.Administration_Users" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="container-fluid" id="divFormFields" runat="server">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-xs-12 col-sm-6">
				<div class="center-block">
					<div class="newUserForm GradientSilverDiagonal" style="float:right;">
						<h2>Create a New User Account</h2>
						<p>
							Use the form below to add users.
							<p>
							<small>
								An email with the login information will be sent to the user at the address specified.
							</small>
							</p>
						</p>
						<asp:HiddenField ID="hidOrganizationId" runat="server" />
						<asp:Label id="Msg" ForeColor="red" runat="server" /><br />
							<table cellpadding="3" border="0">	
								<tr runat="server" id="trOrganizationMsg" visible="false">
									<td colspan="2">
										Select the Organization for this user.
									</td>
								</tr>
								<tr runat="server" id="trOrganization" visible="false">
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
									<td colspan="2">
										Enter the new users first and last name.
									</td>
								</tr>
								<tr>
									<td>
											Firstname
									</td>
									<td>
											<asp:TextBox runat="server" ID="txtFirstname"></asp:TextBox>
											<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ControlToValidate="txtFirstname" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>
								<tr>
									<td>
											Lastname
									</td>
									<td>
											<asp:TextBox runat="server" ID="txtLastname"></asp:TextBox>
											<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="txtLastname" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<h4>Select Roles</h4>
										<asp:CheckBoxList CellPadding="7" CssClass="CheckboxList" ID="cblRoles" runat="server"></asp:CheckBoxList>
									</td>
								</tr>
								<tr>
									<td>Username:</td>
									<td>
										<asp:Textbox id="UsernameTextbox" runat="server" />
										<asp:RequiredFieldValidator id="UsernameRequiredValidator" runat="server" ControlToValidate="UserNameTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>
								<tr>
									<td>Password:</td>
									<td>
										<asp:Textbox id="PasswordTextbox" runat="server" TextMode="Password" />
										<asp:RequiredFieldValidator id="PasswordRequiredValidator" runat="server" ControlToValidate="PasswordTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>
								<tr>
									<td valign="top" style="white-space: nowrap;">Confirm Password:</td>
									<td>
										<asp:Textbox id="PasswordConfirmTextbox" runat="server" TextMode="Password" />
										<asp:RequiredFieldValidator id="PasswordConfirmRequiredValidator" runat="server" ControlToValidate="PasswordConfirmTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
										<asp:CompareValidator id="PasswordConfirmCompareValidator" runat="server" ControlToValidate="PasswordConfirmTextbox" ForeColor="red" Display="Dynamic" ControlToCompare="PasswordTextBox" ErrorMessage="Confirm password must match password." />
									</td>
								</tr>
								<tr>
									<td valign="top" style="white-space: nowrap;">Email Address:</td>
									<td>
										<asp:Textbox id="EmailTextbox" runat="server" />
										<asp:RequiredFieldValidator id="EmailRequiredValidator" runat="server" ControlToValidate="EmailTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>


								<% if (Membership.RequiresQuestionAndAnswer) { %>

								<tr>
									<td valign="top" style="white-space: nowrap;">Password Question:</td>
									<td>
										<asp:Textbox id="PasswordQuestionTextbox" runat="server" />
										<asp:RequiredFieldValidator id="PasswordQuestionRequiredValidator" runat="server" ControlToValidate="PasswordQuestionTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>
								<tr>
									<td valign="top" style="white-space: nowrap;">Password Answer:</td>
									<td>
										<asp:Textbox id="PasswordAnswerTextbox" runat="server" />
										<asp:RequiredFieldValidator id="PasswordAnswerRequiredValidator" runat="server" ControlToValidate="PasswordAnswerTextbox" ForeColor="red" Display="Dynamic" ErrorMessage="Required" />
									</td>
								</tr>

								<% } %>

								<tr>
									<td></td>
									<td><asp:Button id="CreateUserButton" Text="Create User" OnClick="CreateUser_OnClick" runat="server" /></td>
								</tr>
							</table>
						</div>

						<div style="padding:0px 20px; display:inline-block;">
							<asp:DataList ID="dlUsers" runat="server" RepeatLayout="Table" OnItemDataBound="dlUsers_ItemDataBound">
								<HeaderTemplate>
									<table border="0" cellpadding="15" cellspacing="0" style="border-collapse:collapse;">
										<tr>
											<td colspan="3">
												<h3>User Accounts</h3>
												Number of Users Online: <asp:Label id="UsersOnlineLabel" runat="Server" />
											</td>
										</tr>
										<tr style="background-color:gainsboro">
											<td>Username</td><td>Full Name</td><td>Organization</td><td>Created</td><td>Last Login</td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td valign="top">
											<%# DataBinder.Eval(Container.DataItem, "Username") %>
										</td>
										<td valign="top">
											<asp:LinkButton CausesValidation="false" ID="lbUser" Width="250" Font-Underline="false" runat="server" OnClick="divUser_Click" userName='<%# DataBinder.Eval(Container.DataItem, "Username") %>'>
												<div runat="server" id="divUser"><b><%#Eval("Fullname") %></b></div>
											</asp:LinkButton>
										</td>
										<td valign="top">
											<asp:DataList ID="dlOrganizations" runat="server" OnItemDataBound="dlOrganizations_ItemDataBound">
												<ItemTemplate>
													<asp:HyperLink ID="hypOrganization" runat="server"  Font-Underline="false" Font-Bold="true"></asp:HyperLink>
												</ItemTemplate>
											</asp:DataList>
										</td>
										<td valign="top">
											<asp:Label ID="lblCreatedOn" runat="server"></asp:Label>
										</td>
										<td valign="top">
											<asp:Label ID="lblLastActivityDate" runat="server"></asp:Label>
										</td>
									</tr>
									<tr>
										<td valign="top" colspan="5">
											<asp:Label ID="lblRoles" runat="server"></asp:Label>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<hr />
										</td>
									</tr>
								</ItemTemplate>
								<FooterTemplate>
									</table>
								</FooterTemplate>
							</asp:DataList>
						</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Organization.aspx.cs" Inherits="CrowdRelief.Administration_Organization" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divRegisterFormOuter">
        <div id="divFormFields" runat="server" class="divRegisterForm" style="width:600px; padding-bottom:100px;">
            <h2>New Organization</h2>
            Enter your teams information below, then invite them to register to join your organization.
            <br /><br /><br />
            <table style="width:600px;" cellpadding="5">
                <tr>
                    <td colspan="2">
						<div style="border:solid 1px black; padding:20px; margin:20px 0px; background-color:#BEE197;">
							<h3>Choose the disasters your organization addresses</h3>
							Leave unchecked if none apply at this time.
							<br /><br />
							<asp:CheckBoxList ID="chkBoxList" runat="server" DataTextField="Name" DataValueField="EventId" RepeatDirection="Vertical"></asp:CheckBoxList>
						</div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <h2>Organization Information</h2>
                        Please enter your details below.
                        <br /><br />
                    </td>
                </tr>
                <tr>
					<td style="vertical-align:top;">
						Organization Name *
                    <asp:RequiredFieldValidator id="RequiredFieldValidator2" Display="Dynamic" runat="server" ControlToValidate="txtOrganizationName" ErrorMessage="Organization Name is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtOrganizationName" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Organization Description *
                    <asp:RequiredFieldValidator id="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtOrganizationDetails" ErrorMessage="Organization Details is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtOrganizationDetails" runat="server" TextMode="MultiLine" Rows="20" Width="300" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Phone Number *
                    <asp:RequiredFieldValidator id="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="txtPrimaryPhone" ErrorMessage="Phone Number is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtPrimaryPhone" runat="server" Width="100" MaxLength="12" CssClass="registerFormTextBox"></asp:TextBox> xxx-xxx-xxxx
                    </td>
                </tr>
                <tr>
					<td>
						Alternate Phone Number
					</td>
                    <td>
                        <asp:TextBox ID="txtAlternatePhone" runat="server" Width="100" MaxLength="12" CssClass="registerFormTextBox"></asp:TextBox> xxx-xxx-xxxx
                    </td>
                </tr>
                <tr>
					<td>
						Address *
					<asp:RequiredFieldValidator id="RequiredFieldValidator7" Display="Dynamic" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						City *
					<asp:RequiredFieldValidator id="RequiredFieldValidator6" Display="Dynamic" runat="server" ControlToValidate="txtCity" ErrorMessage="City is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" Width="200" MaxLength="50" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						State or Province *
					<asp:RequiredFieldValidator id="RequiredFieldValidator5" Display="Dynamic" runat="server" ControlToValidate="txtState" ErrorMessage="State is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtState" runat="server" Width="100" MaxLength="50" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Zip Code *
					<asp:RequiredFieldValidator id="RequiredFieldValidator4" Display="Dynamic" runat="server" ControlToValidate="txtZipCode" ErrorMessage="Zip Code is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
					</td>
                    <td>
                        <asp:TextBox ID="txtZipCode" runat="server" Width="60" MaxLength="5" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Facebook URL
					</td>
                    <td>
                        <asp:TextBox ID="txtFacebookURL" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Twitter Username
					</td>
                    <td>
                        <asp:TextBox ID="txtTwitterUsername" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						Instagram Username
					</td>
                    <td>
                        <asp:TextBox ID="txtInstagramUsername" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						YouTube URL
					</td>
                    <td>
                        <asp:TextBox ID="txtYouTubeURL" runat="server" Width="300" MaxLength="300" CssClass="registerFormTextBox"></asp:TextBox>
                    </td>
                </tr>
                <tr>
					<td>
						<asp:HyperLink ID="HyperLink1" runat="server" Text="Return To Home Page" NavigateUrl="~/Default.aspx"></asp:HyperLink>
					</td>
                    <td>
                        <div style="display:block; text-align:right; margin-top:30px;">
                            <asp:Button ID="btn" runat="server" Text="Create New Organization" OnClick="btn_Click" CssClass="ButtonRegister" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divResults" runat="server" visible="false" class="divRegisterForm" style="width:600px; padding-bottom:100px;">
			<b>Welcome</b>
			<h2><asp:Literal ID="lblOrgName" runat="server"></asp:Literal></h2>
            <asp:Label ID="lblResults" runat="server"></asp:Label>
			<br />
			<hr />
			<br /><br />
            <asp:Label ID="lblEvents" runat="server"></asp:Label>
			<br /><br /><br />
			Now invite your team members to join your organization.
        </div>
    </div>
</asp:Content>
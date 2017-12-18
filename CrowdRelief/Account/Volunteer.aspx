<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Volunteer.aspx.cs" Inherits="CrowdRelief.Account_Volunteer" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divRegisterFormOuter">
        <div id="divFormFields" runat="server" class="divRegisterForm" style="width:600px; padding-bottom:100px;">
			<div class="divRegisterAgreeToTermsForm table-responsive">
				<img src="/Images/TEAM-TIGER2.png" class="img-responsive center-block" style="display:inline; padding:10px; padding-top:50px;" alt="Believe">
				<h1>Thanks for Volunteering with Team + Tiger, Cajun Relief Foundation's ground team in Florida.</h1>
				We are pleased you've taken the step to get involved, Team + Tiger volunteers are expected to agree and sign our statement of practice.
				<h3>STATEMENT OF PRACTICE</h3>
				The commitment of the Cajun Relief Foundation is to serve and not to be served. Serving on an assignment means your agreement to the following:
				<ul>
					<li>I am willing to set aside personal preferences, habits and schedule in the interest of others to fulfill the obligation to which I am assigned.</li>
					<li>I understand there are variations in practice and understanding of volunteerism in some areas of culture. In serving with Cajun Relief Foundation, I will abide by the standards of the project to which assigned in all areas including dress, entertainment, activities, etc. This includes a willing agreement to abstain from the use of alcohol, drugs, and tobacco and being sensitive to cultural and regional expectations and standards.</li>
					<li>In cooperation with the Cajun Relief Foundation, I will seek to provide excellence in attitude and to present a professional outlook at all times.</li>
				</ul>
			</div>
            <h3>New Volunteer Form</h3>
            Please fill in the fields below to volunteer with the Cajun Relief Foundation.
			<br /><br />
			<div style="border:solid 1px black; padding:20px; margin:20px 0px; background-color:#BEE197;">
				<h3>Choose the disasters you are volunteering for</h3>
				Leave unchecked if none apply at this time.
				<br /><br />
				<asp:CheckBoxList ID="chkBoxListDisasters" runat="server" DataTextField="Name" DataValueField="EventId" RepeatDirection="Vertical"></asp:CheckBoxList>
				<h3>Choose any organizations you belong to</h3>
				Leave unchecked if none apply at this time.
				<br /><br />
				<asp:CheckBoxList ID="chkBoxOrganizations" runat="server" DataTextField="Name" DataValueField="OrganizationId" RepeatDirection="Vertical"></asp:CheckBoxList>
			</div>
            <table class="table-responsive">
                <tr>
                    <td colspan="2">
                        <h2>Volunteer Information</h2>
                        Please describe in detail your skills and how you think you can help. (max 1000 characters)
                        <asp:RequiredFieldValidator id="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="txtDescription" ErrorMessage="Your skills are a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
						<br />
						<asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="20" Width="500" MaxLength="1000"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
						Relevant skills
						<br />
						<asp:CheckBoxList ID="chkBoxListSkills" RepeatColumns="2" runat="server" DataTextField="Name" DataValueField="SkillId" RepeatDirection="Vertical"></asp:CheckBoxList>
                    </td>
                </tr>
				<tr>
                    <td colspan="2">
						Dates Available *
						<asp:RequiredFieldValidator id="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtDatesAvailable" ErrorMessage="Dates available is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
						<br />
						<asp:TextBox ID="txtDatesAvailable" runat="server" Width="300" MaxLength="500" CssClass="registerFormTextBox"></asp:TextBox>
					</td>
				</tr>
				<tr>
                    <td colspan="2">
						How many days are you available to serve? *
						<asp:RequiredFieldValidator id="RequiredFieldValidator2" Display="Dynamic" runat="server" ControlToValidate="txtDaysAvailable" ErrorMessage="Number of days available is a required field." Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
						<br />
                        <asp:TextBox ID="txtDaysAvailable" runat="server" Width="300" MaxLength="4" CssClass="registerFormTextBox"></asp:TextBox>
					</td>
				</tr>
				<tr>
                    <td colspan="2">
						Previous Volunteer Experience. Please include with whom, places and dates.
						<br />
						<asp:TextBox ID="txtPreviousExperience" runat="server" TextMode="MultiLine" Rows="20" Width="500" MaxLength="1000"></asp:TextBox>
					</td>
				</tr>
                <tr>
                    <td colspan="2">
                        <div style="display:block; text-align:right; margin-top:30px;">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="ButtonRegister" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="divResults" runat="server" class="divRegisterForm" visible="false" style="max-width:600px; margin-bottom:30px;">
                <h1>Your Volunteer ID Number - <asp:Literal ID="lblNumber" runat="server"></asp:Literal></h1>
                <asp:Label ID="lblResults" runat="server"></asp:Label>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
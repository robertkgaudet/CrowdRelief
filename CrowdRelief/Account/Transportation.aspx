<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Transportation.aspx.cs" Inherits="Account_Transportation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="divRegisterFormOuter">
        <div class="divRegisterForm" style="width:600px; padding-bottom:100px;">   
            <h2>New Transportation Volunteer</h2>
            Thank you for registering to be a transportation volunteer.
            <br /><br />
            We are pleased you decided to register to be a transportation volunteer, you are needed if you have a large enough vehicle to hot shot items to individuals or if you carry a CDL for driving big rig drivers.
            We will be in contact with you shortly.
            <br /><br /><br />
            <asp:HyperLink ID="hypGoHome" runat="server" Text="Return To Home Page" NavigateUrl="~/Default.aspx"></asp:HyperLink>
        </div>
    </div>
</asp:Content>


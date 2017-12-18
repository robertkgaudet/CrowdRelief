<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Items.aspx.cs" Inherits="Account_Items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="divRegisterFormOuter">
        <div class="divRegisterForm" style="width:600px; padding-bottom:100px;">   
            <h2>Item Donation Information</h2>
            Thank you for registering to donate items.
            <br /><br />
            We have very specific item donation needs at this time. We have your contact information and will speak with you shortly.
            <br /><br /><br />
            <asp:HyperLink ID="hypGoHome" runat="server" Text="Return To Home Page" NavigateUrl="~/Default.aspx"></asp:HyperLink>
        </div>
    </div>
</asp:Content>


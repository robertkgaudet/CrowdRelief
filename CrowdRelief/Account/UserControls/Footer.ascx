<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Footer.ascx.cs" Inherits="Account_UserControls_Footer" %>

		<div class="container-fluid bg-6 text-center" style="background-color:#35478C; color:#ffffff; min-height:400px; padding:60px;">
			<div class="row">
				<div class="col-xs-12">
					<a href="/About.aspx" style="color:white;">About CrowdRelief</a> | <a href="/Contact.aspx" style="color:white;">Contact Us</a>
					<!--<a href="/LouisianaFlooding.aspx">ABOUT THE LOUISIANA FLOODING</a>-->
					<h4 style="color:white;">CrowdRelief Partner Organizations</h4>
					<asp:DataList RepeatLayout="Flow" RepeatDirection="Horizontal" ID="dlPartners" runat="server" OnItemDataBound="dlPartners_ItemDataBound">
						<ItemTemplate>
							<asp:HyperLink Target="_blank" ID="hypPartners" runat="server">
							<asp:Image ID="imgPartners" runat="server" CssClass="img-thumbnail img-small" />
							</asp:HyperLink>
						</ItemTemplate>
					</asp:DataList>
					<p style="color:white;">
						© 2017 - CrowdRelief | All Rights Reserved
						<br />
						<b>Flood Victim?</b> Get your household needs survey completed. Call 225–289–3950 9am-3pm M-F 9am-Noon on Sat.
					</p>
					<small>CrowdRelief is a private company and is not affiliated with any state, local or federal government relief efforts.</small>
				</div>
			</div>
		</div>
		<!-- Footer-->
		<footer class="footer" style="margin-bottom:0px; position:fixed;">
			<span class="pull-right">
				All Rights Reserved
			</span>
			© 2017 - CrowdRelief
		</footer>
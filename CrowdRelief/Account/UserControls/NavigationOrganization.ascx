<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NavigationOrganization.ascx.cs" Inherits="Account_UserControls_NavigationOrganization" %>

		<aside id="menu">
			<div id="navigation">
				<div class="profile-picture">
					<a href="Default.aspx">
						<asp:Image ID="imgLogo" runat="server" CssClass="m-b img-thumbnail img-responsive" />
					</a>
					<div class="stats-label text-color">
						<span class="font-extra-bold font-uppercase">
							<asp:Literal ID="litOrganization" runat="server"></asp:Literal>
						</span>
						<div class="dropdown">
							<a class="dropdown-toggle" href="#" data-toggle="dropdown">
								<small class="text-muted">Account <b class="caret"></b></small>
							</a>
							<ul class="dropdown-menu animated flipInX m-t-xs">
								<li><a href="Default.aspx">Home</a></li>
								<li><asp:LoginStatus ID="loginStatus" runat="server" LoginText="LOG IN" LogoutText="Logout" /></li>
							</ul>
						</div>
					</div>
				</div>

				<ul class="nav" id="side-menu">
					<li class="active">
						<a href="Default.aspx"> <span class="nav-label">RELIEF WORK</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="ReliefStream.aspx">Relief Stream</a></li>
							<li><a href="/NonProfitCampaigns.aspx">Donate to Flood Victims</a></li>
							<li><a href="Default.aspx">Disasters</a></li>
							<li><a href="DisasterNeedsMap.aspx">Disaster Needs Map</a></li>
							<li><a href="Collaborators.aspx">Collaborators</a></li>
							<li><a href="Volunteers.aspx">Volunteers</a></li>
							<li style="display:none;"><a href="Resources.aspx">Resources</a></li>
						</ul>
					</li>
					<li style="display:none;">
						<a href="MyJourney.aspx"> <span class="nav-label">MY JOURNAL</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="Timeline.aspx">Timeline</a></li>
							<li><a href="MyJourney.aspx">Journal</a></li>
							<li><a href="Gallery.aspx">Gallery</a></li>
						</ul>
					</li>
					<li style="display:none;">
						<a href="MyJourney.aspx"> <span class="nav-label">COMMUNITY STREAM</span> </a>
					</li>
					<li style="display:none;">
						<a href="MyCommunity.aspx"> <span class="nav-label">LOCAL COMMUNITY</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="Friends.aspx">Friends</a></li>
							<li><a href="Neighbors.aspx">Neighbors</a></li>
							<li><a href="Churches.aspx">Churches</a></li>
							<li><a href="Churches.aspx">Non-Profit Organizations</a></li>
							<li><a href="Businesses.aspx">Businesses</a></li>
							<li><a href="LocalGovernment.aspx">Local Government</a></li>
						</ul>
					</li>
					<li style="display:none;">
						<a href="FindRelief.aspx"> <span class="nav-label">TRAINING</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="ReliefOrganizations.aspx">Relief Organizations</a></li>
							<li><a href="FindItems.aspx">Find Items</a></li>
							<li><a href="OnlineResources.aspx">Read Online Resources</a></li>
							<li><a href="HelpOverview.aspx">Help Summary</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</aside>
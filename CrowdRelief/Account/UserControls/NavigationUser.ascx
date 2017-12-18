<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NavigationUser.ascx.cs" Inherits="Account_UserControls_NavigationUser" %>

		<aside id="menu">
			<div id="navigation">
				<div class="profile-picture">
					<a href="Default.aspx">
						<img src="/images/etta.png" class="img-circle m-b" alt="logo">
					</a>
					<div class="stats-label text-color">
						<span class="font-extra-bold font-uppercase">Etta Daughdrill</span>
						<div class="dropdown">
							<a class="dropdown-toggle" href="#" data-toggle="dropdown">
								<small class="text-muted">Account <b class="caret"></b></small>
							</a>
							<ul class="dropdown-menu animated flipInX m-t-xs">
								<li><a href="Profile.aspx">Profile</a></li>
								<li><a href="Account.aspx">Account</a></li>
								<li><a href="MySurveys.aspx">My Surveys</a></li>
								<li><a href="MyTimesheet.aspx">My Timesheet</a></li>
								<li><a href="#">Sign Out</a></li>
							</ul>
						</div>
					</div>
				</div>

				<ul class="nav" id="side-menu">
					<li class="active">
						<a href="Default.aspx"> <span class="nav-label">HOME</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="Default.aspx">Recovery Dashboard</a></li>
							<li><a href="ProgressUpdates.aspx">Update My Progress</a></li>
							<li><a href="RebuildSurveys.aspx">Take Rebuild Surveys</a></li>
							<li><a href="Messages.aspx">Messages</a></li>
						</ul>
					</li>
					<li>
						<a href="MyJourney.aspx"> <span class="nav-label">MY JOURNAL</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="Timeline.aspx">Timeline</a></li>
							<li><a href="MyJourney.aspx">Journal</a></li>
							<li><a href="Gallery.aspx">Gallery</a></li>
						</ul>
					</li>
					<li>
						<a href="MyJourney.aspx"> <span class="nav-label">COMMUNITY STREAM</span> </a>
					</li>
					<li>
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
					<li>
						<a href="FindRelief.aspx"> <span class="nav-label">FIND HELP</span> <span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="ReliefOrganizations.aspx">Connect with Relief Organizations</a></li>
							<li><a href="FindItems.aspx">Find Items</a></li>
							<li><a href="OnlineResources.aspx">Read Online Resources</a></li>
							<li><a href="HelpOverview.aspx">Help Summary</a></li>
						</ul>
					</li>

				</ul>
			</div>
		</aside>
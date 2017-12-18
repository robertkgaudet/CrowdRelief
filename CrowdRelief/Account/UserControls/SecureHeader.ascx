<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SecureHeader.ascx.cs" Inherits="Account_UserControls_SecureHeader" %>

		<div id="header">
			<div class="color-line"></div>
			<div id="logo" class="light-version">
				<span>
					<a href="/Default.aspx">CROWDRELIEF</a>
				</span>
			</div>

			<nav role="navigation">
				<div class="header-link hide-menu"><i class="fa fa-bars"></i></div>
				<div class="small-logo">
					<span class="text-primary">CROWDRELIEF</span>
				</div>
				<div class="mobile-menu">
					<button type="button" class="navbar-toggle mobile-menu-toggle" data-toggle="collapse" data-target="#mobile-collapse">
						<i class="fa fa-chevron-down"></i>
					</button>
					<div class="collapse mobile-navbar" id="mobile-collapse">
						<ul class="nav navbar-nav">
							<li><a href="Profile.aspx">Profile</a></li>
							<li><a href="Account.aspx">Account</a></li>
							<li><a href="MySurveys.aspx">My Surveys</a></li>
							<li><a href="MyTimesheet.aspx">My Timesheet</a></li>
							<li><a href="#">Sign Out</a></li>
						</ul>
					</div>
				</div>
				<div class="navbar-right">
						<div class="collapse navbar-collapse" id="myNavbar">
							<ul class="nav navbar-nav navbar-right navigationLinks">
								<li><a href="/NonProfitCampaigns.aspx">FLOOD VICTIMS</a></li>
								<li><a href="/ClientLocationMap.aspx">DISASTER NEEDS MAP &trade;</a></li>
								<li><a href="/About.aspx">ABOUT</a></li>
								<li><a href="/Contact.aspx">CONTACT</a></li>
									<asp:LoginView ID="loginView" runat="server">
										<AnonymousTemplate>
											<li><a href="/Register.aspx?interactionType=Help">REGISTER</a></li>
											<li><a href="/Register.aspx?interactionType=Volunteer">VOLUNTEER</a></li>
										</AnonymousTemplate>
										<LoggedInTemplate>
											<li><a href="/Account/Profile.aspx" class="dropdown-toggle" data-toggle="dropdown"><asp:Literal ID="lblFullName" runat="server"></asp:Literal> <span class="caret"></a>
												<ul class="dropdown-menu">
													<li runat="server" id="liTotalNeedsCost" visible="false"><asp:HyperLink ID="hypMyTotalNeedsCost" runat="server"></asp:HyperLink> </li>
													<li runat="server" id="liTotalTime" visible="false"><a href="/Account/Timesheet.aspx" ID="hypMyTimesheet" runat="server" CssClass="btn btn-sm btn-primary timesheetbutton"  data-toggle="tooltip" data-placement="bottom" title="Your total points added up from your timesheet. 1 hour = 1 point."></a></li>	
													<li><a href="/Account/BasicNeedsSurvey.aspx" style="font-weight:bold;">Request Help</a></li>
													<li><asp:HyperLink ID="hypRegisterAsVolunteer" runat="server" Text="Register as a Volunteer" NavigateUrl="~/Account/Volunteer.aspx"></asp:HyperLink></li>
													<li runat="server" id="liAdmin" visible="false"><a href="/Administration/Default.aspx">Administration</a></li>
													<li runat="server" id="liMySurveys" visible="false"><a href="/Account/MySurveys.aspx">My Surveys</a></li>
													<li runat="server" id="liRebuildAdmin" visible="false"><a href="/Account/Organization/Default.aspx">Disaster Dashboard</a></li>
													<li runat="server" id="liMyCases" visible="false"><a href="/Account/MyCases.aspx?userId=<%=userId %>">My Cases</a></li>
													<li runat="server" id="liMyCampaigns" visible="false"><a href="/Campaigns.aspx?userId=<%=userId %>">My Campaigns</a></li>
													<li runat="server" id="liMyTimesheet"><a href="/Account/Timesheet.aspx">Time Clock</a></li>
													<li><a href="/Account/Profile.aspx">My Account</a></li>
													<li><asp:LoginStatus ID="loginStatus" runat="server" LoginText="LOG IN" LogoutText="Logout" /></li>
												</ul>
											</li>
										</LoggedInTemplate>
									</asp:LoginView>
								<li><asp:LoginStatus ID="loginStatus1" runat="server" LogoutText="" LoginText="LOG IN" /></li>
							</ul>
						</div>
				</div>
			</nav>
		</div>
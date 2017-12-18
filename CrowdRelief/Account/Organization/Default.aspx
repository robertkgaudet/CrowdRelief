<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureOrganization.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Account_Organization_Default" %>

<%-- Add content controls here --%>

<asp:Content id="Content1" ContentPlaceholderID="HeadContentPlaceHolder" runat="server">
	<style>	
	.post-logo
		{
			width:40px;
			float:left;
		}
	</style>
</asp:Content>

<asp:Content id="Content2" ContentPlaceholderID="BodyContentPlaceHolder1" runat="server">
	
<div id="wrapper">
	<div class="content animate-panel" data-child="hpanel">
		<div class="normalheader ">
			<div class="hpanel">
				<div class="panel-body">
					<a class="small-header-action" href="">
						<div class="clip-header">
							<i class="fa fa-arrow-up"></i>
						</div>
					</a>

					<div id="hbreadcrumb" class="pull-right m-t-lg">
						<ol class="hbreadcrumb breadcrumb">
							<li class="active"><span>Disasters</span></li>
						</ol>
					</div>
					<h2 class="font-light m-b-xs">
						Disaster Projects
					</h2>
					<small>Manage projects and collaborate with local non-profits after a disaster.</small>
				</div>
			</div>
		</div>
		<div class="content">
			<div class="row projects">
				<div class="col-lg-6">
					<div class="hpanel">
						<div class="panel-body">
							<span class="label label-info pull-right">Start Date Thursday September 7th, 2017</span>
							<div class="row">
								<div class="col-sm-8">
									<h4><a href="Rebuilds.aspx">Hurricane Irma</a></h4>
									<p>
										Rebuilding homes, engaging volunteers and helping our neighbors.
									</p>
								
									<div class="row">
										<div class="col-sm-12">
											<div class="project-label">Progress <%=progressPercentIrma%>%</div>
											<div class="progress m-t-xs full progress-small">
												<div style="width:<%=progressPercentIrma%>%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="<%=progressPercent%>" role="progressbar" class=" progress-bar progress-bar-success">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4 project-info m-b-lg">
									<div class="project-action m-t-md" style="display:none;">
										<div class="btn-group">
											<button class="btn btn-xs btn-default"> View</button>
											<button class="btn btn-xs btn-default"> Edit</button>
											<button class="btn btn-xs btn-default"> Archive</button>
										</div>
									</div>
									<div class="project-value" style="display:none;">
										<h2 class="text-success">
											$1 206,40
										</h2>
									</div>
									<div class="m-t-lg">
										<div class="m-b-sm border-bottom">
											<asp:Literal ID="Literal7" runat="server"></asp:Literal>
										</div>
										<asp:Repeater ID="Repeater2" runat="server">
											<ItemTemplate>
												<a href="OrganizationProfile.aspx?organizationId=<%# DataBinder.Eval(Container.DataItem, "OrganizationId") %>">
													<img alt='<%# DataBinder.Eval(Container.DataItem, "Name") %>' class="post-logo pull-left img-thumbnail" src='/Images/Organizations/<%# DataBinder.Eval(Container.DataItem, "Logo") %>' />
												</a>
											</ItemTemplate>
										</asp:Repeater>
									</div>
								</div>
							</div>	
							<div class="row">
								<div class="col-md-6">
									<div class="hpanel hbggreen">
										<div class="panel-body">
											<div class="text-center">
												<h3>Progress</h3>
												<p class="text-big font-light">
													<%=progressPercentIrma%>%
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="hpanel hbgyellow">
										<div class="panel-body">
											<div class="text-center">
												<h3>Volunteers Needed</h3>
												<p class="text-big font-light">
													<%=totalVolunteersNeeded%>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<div class="project-label">ACTIVE</div>
									<small><asp:Literal id="Literal8" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ON DECK</div>
									<small><asp:Literal id="Literal9" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">COMPLETE</div>
									<small><asp:Literal id="Literal10" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ICEBOX</div>
									<small><asp:Literal id="Literal11" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">TOTAL</div>
									<small><asp:Literal id="Literal12" runat="server"></asp:Literal> </small>
								</div>
								<div class="col-sm-2"></div>
							</div>
						</div>
						<div class="panel-footer">
							Rebuild project active since September 3rd, 2016
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="hpanel">
						<div class="panel-body">
							<span class="label label-info pull-right">Start Date September 3rd 2016</span>
							<div class="row">
								<div class="col-sm-8">
									<h4><a href="Rebuilds.aspx">Hurricane Harvey</a></h4>

									<p>
										Rebuilding homes, engaging volunteers and helping our neighbors.
									</p>
								
									<div class="row">
										<div class="col-sm-12">
											<div class="project-label">Progress <%=progressPercentHarvey%>%</div>
											<div class="progress m-t-xs full progress-small">
												<div style="width:<%=progressPercentHarvey%>%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="<%=progressPercent%>" role="progressbar" class=" progress-bar progress-bar-success">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4 project-info m-b-lg">
									<div class="project-action m-t-md" style="display:none;">
										<div class="btn-group">
											<button class="btn btn-xs btn-default"> View</button>
											<button class="btn btn-xs btn-default"> Edit</button>
											<button class="btn btn-xs btn-default"> Archive</button>
										</div>
									</div>
									<div class="project-value" style="display:none;">
										<h2 class="text-success">
											$1 206,40
										</h2>
									</div>
									<div class="m-t-lg">
										<div class="m-b-sm border-bottom">
											<asp:Literal ID="Literal1" runat="server"></asp:Literal>
										</div>
										<asp:Repeater ID="Repeater1" runat="server">
											<ItemTemplate>
												<a href="OrganizationProfile.aspx?organizationId=<%# DataBinder.Eval(Container.DataItem, "OrganizationId") %>">
													<img alt='<%# DataBinder.Eval(Container.DataItem, "Name") %>' class="post-logo pull-left img-thumbnail" src='/Images/Organizations/<%# DataBinder.Eval(Container.DataItem, "Logo") %>' />
												</a>
											</ItemTemplate>
										</asp:Repeater>
									</div>
								</div>
							</div>	
							<div class="row">
								<div class="col-md-6">
									<div class="hpanel hbggreen">
										<div class="panel-body">
											<div class="text-center">
												<h3>Progress</h3>
												<p class="text-big font-light">
													<%=progressPercentHarvey%>%
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="hpanel hbgyellow">
										<div class="panel-body">
											<div class="text-center">
												<h3>Volunteers Needed</h3>
												<p class="text-big font-light">
													<%=totalVolunteersNeeded%>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<div class="project-label">ACTIVE</div>
									<small><asp:Literal id="Literal2" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ON DECK</div>
									<small><asp:Literal id="Literal3" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">COMPLETE</div>
									<small><asp:Literal id="Literal4" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ICEBOX</div>
									<small><asp:Literal id="Literal5" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">TOTAL</div>
									<small><asp:Literal id="Literal6" runat="server"></asp:Literal> </small>
								</div>
								<div class="col-sm-2"></div>
							</div>
						</div>
						<div class="panel-footer">
							Rebuild project active since September 3rd, 2016
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="hpanel" style="display:none;">
						<div class="panel-body">
							<span class="label label-info pull-right">Start Date September 3rd 2016</span>
							<div class="row">
								<div class="col-sm-8">
									<h4><a href="Rebuilds.aspx">Louisiana Flooding Contents Replacement</a></h4>
									<p>
										Helping elderly, low income, disabled and at risk citizens replace items in their home through crowdfunding.
									</p>
									<div class="row">
										<div class="col-sm-3">
											<div class="project-label">CLIENT</div>
											<small>Vito Company</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">VERSION</div>
											<small>3.0.0</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">DEDLINE</div>
											<small>16.10.2015</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">PROGRESS</div>
											<div class="progress m-t-xs full progress-small">
												<div style="width: 65%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="65" role="progressbar" class=" progress-bar progress-bar-warning">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4 project-info">
									<div class="project-action m-t-md">
										<div class="btn-group">
											<button class="btn btn-xs btn-default"> View</button>
											<button class="btn btn-xs btn-default"> Edit</button>
											<button class="btn btn-xs btn-default"> Archive</button>
										</div>
									</div>
									<div class="project-value">
										<h2 class="text-warning">
											$3 600,20
										</h2>
									</div>
									<div class="project-people">
										<img alt="logo" class="img-circle" src="/images/a7.jpg">
										<img alt="logo" class="img-circle" src="/images/a8.jpg">
										<img alt="logo" class="img-circle" src="/images/a3.jpg">
										<img alt="logo" class="img-circle" src="/images/a2.jpg">
										<img alt="logo" class="img-circle" src="/images/a5.jpg">
									</div>
								</div>
							</div>
						</div>
						<div class="panel-footer">
							Contents replacement project active since September 3rd, 2016
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="hpanel">
						<div class="panel-body">
							<span class="label label-info pull-right">Start Date September 3rd 2016</span>
							<div class="row">
								<div class="col-sm-8">
									<h4><a href="Rebuilds.aspx">August 2016, Louisiana Flood Home Rebuilds</a></h4>

									<p>
										Rebuilding homes in South Louisiana after disasterous floods displaced hundreds of thousands of people.
									</p>
								
									<div class="row">
										<div class="col-sm-12">
											<div class="project-label">Progress <%=progressPercent%>%</div>
											<div class="progress m-t-xs full progress-small">
												<div style="width:<%=progressPercent%>%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="<%=progressPercent%>" role="progressbar" class=" progress-bar progress-bar-success">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4 project-info m-b-lg">
									<div class="project-action m-t-md" style="display:none;">
										<div class="btn-group">
											<button class="btn btn-xs btn-default"> View</button>
											<button class="btn btn-xs btn-default"> Edit</button>
											<button class="btn btn-xs btn-default"> Archive</button>
										</div>
									</div>
									<div class="project-value" style="display:none;">
										<h2 class="text-success">
											$1 206,40
										</h2>
									</div>
									<div class="m-t-lg">
										<div class="m-b-sm border-bottom">
											<asp:Literal ID="litCollaboratingOrganizations" runat="server"></asp:Literal>
										</div>
										<asp:Repeater ID="rptCollaborators" runat="server">
											<ItemTemplate>
												<a href="OrganizationProfile.aspx?organizationId=<%# DataBinder.Eval(Container.DataItem, "OrganizationId") %>">
													<img alt='<%# DataBinder.Eval(Container.DataItem, "Name") %>' class="post-logo pull-left img-thumbnail" src='/Images/Organizations/<%# DataBinder.Eval(Container.DataItem, "Logo") %>' />
												</a>
											</ItemTemplate>
										</asp:Repeater>
									</div>
								</div>
							</div>	
							<div class="row">
								<div class="col-md-6">
									<div class="hpanel hbggreen">
										<div class="panel-body">
											<div class="text-center">
												<h3>Progress</h3>
												<p class="text-big font-light">
													<%=progressPercent%>%
												</p>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="hpanel hbgyellow">
										<div class="panel-body">
											<div class="text-center">
												<h3>Volunteers Needed</h3>
												<p class="text-big font-light">
													<%=totalVolunteersNeeded%>
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-2">
									<div class="project-label">ACTIVE</div>
									<small><asp:Literal id="litActive" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ON DECK</div>
									<small><asp:Literal id="litOnDeck" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">COMPLETE</div>
									<small><asp:Literal id="litComplete" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">ICEBOX</div>
									<small><asp:Literal id="litIceBox" runat="server"></asp:Literal></small>
								</div>
								<div class="col-sm-2">
									<div class="project-label">TOTAL</div>
									<small><asp:Literal id="litTotal" runat="server"></asp:Literal> </small>
								</div>
								<div class="col-sm-2"></div>
							</div>
						</div>
						<div class="panel-footer">
							Rebuild project active since September 3rd, 2016
						</div>
					</div>
				</div>
			</div>
			<div class="row projects">
				<div class="col-lg-6">
					<div class="hpanel" style="display:none;">
						<div class="panel-body">
							<span class="label label-info pull-right">Start Date September 3rd 2016</span>
							<div class="row">
								<div class="col-sm-8">
									<h4><a href="Rebuilds.aspx">Louisiana Flooding Contents Replacement</a></h4>
									<p>
										Helping elderly, low income, disabled and at risk citizens replace items in their home through crowdfunding.
									</p>
									<div class="row">
										<div class="col-sm-3">
											<div class="project-label">CLIENT</div>
											<small>Vito Company</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">VERSION</div>
											<small>3.0.0</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">DEDLINE</div>
											<small>16.10.2015</small>
										</div>
										<div class="col-sm-3">
											<div class="project-label">PROGRESS</div>
											<div class="progress m-t-xs full progress-small">
												<div style="width: 65%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="65" role="progressbar" class=" progress-bar progress-bar-warning">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-4 project-info">
									<div class="project-action m-t-md">
										<div class="btn-group">
											<button class="btn btn-xs btn-default"> View</button>
											<button class="btn btn-xs btn-default"> Edit</button>
											<button class="btn btn-xs btn-default"> Archive</button>
										</div>
									</div>
									<div class="project-value">
										<h2 class="text-warning">
											$3 600,20
										</h2>
									</div>
									<div class="project-people">
										<img alt="logo" class="img-circle" src="/images/a7.jpg">
										<img alt="logo" class="img-circle" src="/images/a8.jpg">
										<img alt="logo" class="img-circle" src="/images/a3.jpg">
										<img alt="logo" class="img-circle" src="/images/a2.jpg">
										<img alt="logo" class="img-circle" src="/images/a5.jpg">
									</div>
								</div>
							</div>
						</div>
						<div class="panel-footer">
							Contents replacement project active since September 3rd, 2016
						</div>
					</div>
				</div>
				<div class="col-lg-6">
				</div>
			</div>
		</div>
	</div>
</div>

</asp:Content>
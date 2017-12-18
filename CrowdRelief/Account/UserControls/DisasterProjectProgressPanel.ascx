<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DisasterProjectProgressPanel.ascx.cs" Inherits="Account_UserControls_DisasterProjectProgressPanel" %>
							<div class="row">
								<div class="col-md-6">
									<div class="hpanel hbggreen text-white">
										<div class="panel-body">
											<div class="text-center">
												<h3>Progress</h3>
												<span class="text-big font-white">
													<asp:Literal ID="litProgressPercent" runat="server"></asp:Literal>
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="hpanel hbgyellow text-white">
										<div class="panel-body">
											<div class="text-center">
												<h3>Volunteers Needed</h3>
												<span class="text-big text-white">
													<asp:Literal ID="litTotalVolunteersNeeded" runat="server"></asp:Literal>
												</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row text-center m-b-sm">
								<div class="col-sm-4">
									<div class="bg-info text-blue p-sm">
										ACTIVE
										<small><asp:Literal id="litActive" runat="server"></asp:Literal></small>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="bg-info text-blue p-sm">
										DONE
										<small><asp:Literal id="litComplete" runat="server"></asp:Literal></small>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="bg-info text-blue p-sm">
										TOTAL
										<small><asp:Literal id="litTotal" runat="server"></asp:Literal> </small>
									</div>
								</div>
							</div>
							<div class="row text-center">
								<div class="col-sm-6">
									<div class="bg-info text-blue p-sm">
										ON DECK
										<small><asp:Literal id="litOnDeck" runat="server"></asp:Literal></small>
									</div>
								</div>
								<div class="col-sm-6">
									<div class="bg-info text-blue p-sm">
										WAITING
										<small><asp:Literal id="litIceBox" runat="server"></asp:Literal></small>
									</div>
								</div>
							</div>
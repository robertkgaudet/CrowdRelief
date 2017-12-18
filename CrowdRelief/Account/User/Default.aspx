<%@ Page Title="" Language="C#" MasterPageFile="~/Account/MasterPages/SecureUser.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Account_RecoveryDashboard_Default" %>

<asp:Content id="Content1" ContentPlaceholderID="HeadContentPlaceHolder" runat="server">

	<script src="/Scripts/vendor/jquery-ui/jquery-ui.min.js"></script>
	<script src="/Scripts/vendor/iCheck/icheck.min.js"></script>
	<script src="/Scripts/vendor/chartjs/Chart.min.js"></script>
	<script src="/Scripts/vendor/sparkline/index.js"></script>
	
	<script type="text/javascript">

		$(document).ready(function ()
		{
			$(function () {

				/**
				 * Options for Line chart
				 */

				var yRebuildLabels = {
					<%=yRebuildLabels%>
				}

				var yOverallLabels = {
					<%=yOverallLabels%>
				}

				var lineRebuildData = {
					labels: [<%=rebuildProgressSpan%>],
					datasets: [
						{
							label: "My Rebuild Progress",
							backgroundColor: "rgba(98,203,49,0.5)",
							borderColor: "rgba(98,203,49,0.8)",
							highlightFill: "rgba(98,203,49,0.75)",
							highlightStroke: "rgba(98,203,49,1)",
							borderWidth: 1,
							data: [<%=rebuildProgressDataUser%>]
						},
						{
							label: "Community Rebuild Progress",
							backgroundColor: "rgba(220,220,220,0.5)",
							borderColor: "rgba(220,220,220,0.8)",
							highlightFill: "rgba(220,220,220,0.75)",
							highlightStroke: "rgba(220,220,220,1)",
							borderWidth: 1,
							data: [<%=rebuildProgressDataAvg%>]
						}
					]
				};

				var lineOptionsRebuild = {
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'Month'
							}
						}],
						yAxes: [{
							display: true,
							ticks: {
								beginAtZero: true,
								steps: 10,
								stepValue: 10,
								max: <%=rebuildLabelCount%>,
								callback: function(value, index, values) {
									return yRebuildLabels[value];
								}
							}
						}]
					}
				};
					

				var ctx = document.getElementById("lineOptionsRebuild").getContext("2d");
				new Chart(ctx, { type: 'bar', data: lineRebuildData, options: lineOptionsRebuild });



				var lineOverallData = {
					labels: [<%=overallProgressSpan%>],
					datasets: [
						{
							label: "My Overall Progress",
							backgroundColor: "rgba(98,203,49,0.5)",
							borderColor: "rgba(98,203,49,0.8)",
							highlightFill: "rgba(98,203,49,0.75)",
							highlightStroke: "rgba(98,203,49,1)",
							borderWidth: 1,
							data: [<%=overallProgressDataUser%>]
						},
						{
							label: "Overall Community Progress",
							backgroundColor: "rgba(220,220,220,0.5)",
							borderColor: "rgba(220,220,220,0.8)",
							highlightFill: "rgba(220,220,220,0.75)",
							highlightStroke: "rgba(220,220,220,1)",
							borderWidth: 1,
							data: [<%=overallProgressDataAvg%>]
						}
					]
				};

				var lineOptionsOverall = {
					responsive: true,
					scales: {
						xAxes: [{
							display: true,
							scaleLabel: {
								display: true,
								labelString: 'Month'
							}
						}],
						yAxes: [{
							display: true,
							ticks: {
								beginAtZero: true,
								min: 0,
								max: <%=oveallLabelCount%>,
								steps: 11,
								callback: function (value, index, values) {
									return yOverallLabels[value];
								}
							}
						}]
					}
				};

				var ctx = document.getElementById("lineOptionsOverall").getContext("2d");
				new Chart(ctx, { type: 'bar', data: lineOverallData, options: lineOptionsOverall });


			});
		});
	</script>
</asp:Content>

<asp:Content id="Content2" ContentPlaceholderID="BodyContentPlaceHolder1" runat="server">
<div class="content">	
		<div class="hpanel">
			<div class="panel-body">
				<h2 class="font-light m-b-xs">
					Recovery Dashboard
				</h2>
				<small>Information for tracking your recovery after the Louisiana Flooding. </small>
				<br />
				<div class="m-t-lg">
					<a href="ProgressUpdates.aspx" class="btn w-xs btn-info">Update My Progress</a>
				</div>
			</div>
		</div>
	
        <div class="row">
            <div class="col-lg-3">
                <div class="hpanel stats">
                    <div class="panel-heading">
                        <div class="panel-tools">
                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                        </div>
                        Last active
                    </div>
                    <div class="panel-body list">
                        <div class="stats-title pull-left">
                            <h4>Available Funds</h4>
                        </div>
                        <div class="stats-icon pull-right">
                            <i class="pe-7s-cash fa-4x"></i>
                        </div>
                        <div class="m-t-xl">
                            <span class="font-bold no-margins">
                                Rebuild Resources
                            </span>
                            <br/>
                            <small>
                                Cash reserves from insurance, FEMA, potential non-profit funds and crowdfunding.
                            </small>
                        </div>
                        <div class="row m-t-md">
                            <div class="col-lg-6">
								<div class="font-bold">Insurance</div>
                                <h3 class="no-margins font-extra-bold text-success">$30,102</h3>
                                <div class="font-bold">100% available</div>
                            </div>
                            <div class="col-lg-6">
								<div class="font-bold">FEMA</div>
                                <h3 class="no-margins font-extra-bold text-success">$1,200</h3>

                                <div class="font-bold">40% available</div>
                            </div>
                        </div>
                        <div class="row m-t-md">
                            <div class="col-lg-6">
								<div class="font-bold">Non-Profit</div>
                                <h3 class="no-margins font-extra-bold ">$120,108</h3>

                                <div class="font-bold">0% Available</div>
                            </div>
                            <div class="col-lg-6">
								<div class="font-bold">Crowdfunding</div>
                                <h3 class="no-margins font-extra-bold text-success">$5,600</h3>

                                <div class="font-bold">20% Available</div>
                            </div>

                        </div>
                    </div>
                    <div class="panel-footer">
                        <a href="Funding.aspx">Manage Available Funds</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="panel-tools">
                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                        </div>
                        Recently active surveys
                    </div>
                    <div class="panel-body list">
                        <div class="table-responsive project-list">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th colspan="2">Surveys</th>
                                    <th>Completed</th>
                                    <th>Task</th>
                                    <th>Due Date</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><input type="checkbox" class="i-checks" checked></td>
                                    <td>Household Items Survey
                                        <br/>
                                        <small><i class="fa fa-clock-o"></i> Created 14.08.2015</small>
                                    </td>
                                    <td>
                                        <span class="pie">1/5</span>
                                    </td>
                                    <td><strong>20%</strong></td>
                                    <td>Jul 14, 2013</td>
                                    <td><a href=""><i class="fa fa-check text-success"></i></a></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="i-checks"></td>
                                    <td>Rebuild Survey
                                        <br/>
                                        <small><i class="fa fa-clock-o"></i> Created 21.07.2015</small>
                                    </td>
                                    <td>
                                        <span class="pie">1/4</span>
                                    </td>
                                    <td><strong>40%</strong></td>
                                    <td>Jul 16, 2013</td>
                                    <td><a href=""><i class="fa fa-check text-navy"></i></a></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="i-checks" checked></td>
                                    <td>Wellness Survey
                                        <br/>
                                        <small><i class="fa fa-clock-o"></i> Created 12.06.2015</small>
                                    </td>
                                    <td>
                                        <span class="pie">0.52/1.561</span>
                                    </td>
                                    <td><strong>75%</strong></td>
                                    <td>Jul 18, 2013</td>
                                    <td><a href=""><i class="fa fa-check text-navy"></i></a></td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" class="i-checks"></td>
                                    <td>Community Engagement Survey
                                        <br/>
                                        <small><i class="fa fa-clock-o"></i> Created 06.03.2015</small>
                                    </td>
                                    <td>
                                        <span class="pie">226/360</span>
                                    </td>
                                    <td><strong>16%</strong></td>
                                    <td>Jul 22, 2013</td>
                                    <td><a href=""><i class="fa fa-check text-navy"></i></a></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="panel-tools">
                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                        </div>
                        Activity
                    </div>
                    <div class="panel-body list">

                        <div class="pull-right">
                            <a href="#" class="btn btn-xs btn-default">Today</a>
                            <a href="#" class="btn btn-xs btn-default">Month</a>
                        </div>
                        <div class="panel-title">Last Activity</div>
                        <small class="fo">Recent activity for your rebuild</small>
                        <div class="list-item-container">
                            <div class="list-item">
                                <h3 class="no-margins font-extra-bold text-success">2,773</h3>
                                <small>Total Messages Sent</small>
                                <div class="pull-right font-bold">98% <i class="fa fa-level-up text-success"></i></div>
                            </div>
                            <div class="list-item">
                                <h3 class="no-margins font-extra-bold text-color3">4,422</h3>
                                <small>Last activity</small>
                                <div class="pull-right font-bold">13% <i class="fa fa-level-down text-color3"></i></div>
                            </div>
                            <div class="list-item">
                                <h3 class="no-margins font-extra-bold text-color3">9,180</h3>
                                <small>Monthly income</small>
                                <div class="pull-right font-bold">22% <i class="fa fa-bolt text-color3"></i></div>
                            </div>
                            <div class="list-item">
                                <h3 class="no-margins font-extra-bold text-success">1,450</h3>
                                <small>Tota Messages Sent</small>
                                <div class="pull-right font-bold">44% <i class="fa fa-level-up text-success"></i></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
	<div class="row">
		<div class="col-lg-6">
			<div class="hpanel">
				<div class="panel-heading">
					My Rebuild Progress
				</div>
				<div class="panel-body">
					<div>
						<canvas id="lineOptionsRebuild" height="140"></canvas>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-6">
			<div class="hpanel">
				<div class="panel-heading">
					Overall Progress
				</div>
				<div class="panel-body">
					<div>
						<canvas id="lineOptionsOverall" height="140"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</asp:Content>


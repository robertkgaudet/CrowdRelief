<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReliefStream.ascx.cs" Inherits="Account_UserControls_ReliefStream" %>

				<script type="text/javascript">
					//$('.infinite-scroll').jscroll();

					$(document).ready(function ()
					{
						var itemcount = 0;
    					function InfiniteScroll()
						{
    						var $container = $('.chat-discussion');
    						$.ajax(
							{
    							type: "GET",
    							url: "/Handlers/LoadRebuildPosts.ashx?itemcount=" + itemcount,
    							data: "",
    							contentType: "text/plain; charset=utf-8",
    							success: function (data)
								{
    								if (data != "")
    								{
    									$appendedDivs = $(data);
    									$container.append($appendedDivs);
										itemcount += <%=infinateScrollPageSize%>;
    								}
    							}
    						});
    					};

						//Method which fires the InfiniteScroll() function
						$(window).scroll(function ()
						{
							//Call this the first time I start scrolling.
							var firstScroll = true;
							if(firstScroll)
							{
								firstScroll = false;
								InfiniteScroll();
							}
							var scrollTop = $(window).scrollTop();
							var scrollCurrent = ($(document).height() - $(window).height()) / 2;
							//alert(scrollTop + " = " + scrollCurrent);
							if (scrollTop >= scrollCurrent)
							{
								InfiniteScroll();
							}
						});
					});
				</script>
				<div class="hpanel">
					<div class="hpanel">
						<div class="panel-body">

							<h2 class="font-light m-b-xs">
								Rebuild Feed
							</h2>
							<small>Latest Information from the Rebuild Community.</small>
						</div>
					</div>

					<div class="panel-body no-padding">
						<div class="chat-discussion" style="height: auto">
							<asp:Repeater ID="rptPosts" runat="server">
								<ItemTemplate>
									<div class="chat-message">
										<img class="post-logo" src='<%# DataBinder.Eval(Container.DataItem, "Logo") %>'>
										<div class="message">
											<a class="message-author" href='/Account/User/Profile.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ProfileId") %>'> <%# DataBinder.Eval(Container.DataItem, "fullname") %> </a>
											<span class="message-date"> <%# DataBinder.Eval(Container.DataItem, "createdon", "{0:M/d/yyyy HH:mm:ss}") %> </span>
											<span class="message-content">
											<%# DataBinder.Eval(Container.DataItem, "Post") %>
											</span>
										</div>
									</div>
								</ItemTemplate>
							</asp:Repeater>
						</div>
					</div>
				</div>
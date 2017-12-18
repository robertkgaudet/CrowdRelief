<%@ WebHandler Language="C#" Class="LoadRebuildPosts" %>

using System;
using System.Web;
using System.Linq;
using System.Configuration;

public class LoadRebuildPosts : IHttpHandler
{
	public void ProcessRequest (HttpContext context)
	{
		context.Response.ContentType = "text/plain";
		string postHTML = string.Empty;
		string InfinateScrollPageSize = ConfigurationManager.AppSettings["InfinatePostScrollPageSize"].ToString();
		string totalItemCountString = context.Request.QueryString["itemcount"] == null ? "0" : context.Request.QueryString["itemcount"].ToString();

		int currentItemCount = Convert.ToInt32(totalItemCountString);
		int pageSize = Int32.Parse(InfinateScrollPageSize);

		//string memberId = (string)context.Request.QueryString["memberId"];
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var posts = (from rp in dc.RebuildPosts
					 join p in dc.Profiles on rp.UserId equals p.UserId
					 join uo in dc.UserOrganizations on p.UserId equals uo.UserId
					 join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
					 orderby rp.CreatedOn descending
					 where uo.IsPrimary == true
					 select new {
						 o.Name,
						 Logo = ("/Images/Organizations/" + o.Logo),
						 p.ProfileId,
						 rp.Post,
						 rp.CreatedOn,
						 fullname = p.Firstname + " " + p.Lastname,
						 ProfilePhoto = (p.Photo == null ? "Avatar.png" : p.Photo) }).Skip(currentItemCount).Distinct().OrderByDescending(n => n.CreatedOn).Take(pageSize);

		foreach(var post in posts)
		{

			string elapsedTime = CrowdRelief.Tools.GetElapsedTime(post.CreatedOn);

			postHTML += "<div class=\"chat-message\">" + Environment.NewLine +
						"	<img class=\"post-logo\" src='" + post.Logo + "'>" + Environment.NewLine +
						"	<div class=\"message\">" + Environment.NewLine +
						"		<a class=\"message-author\" href='/Account/User/Profile.aspx?id=" + post.ProfileId.ToString() + "'> " + post.fullname + " </a>" + Environment.NewLine +
						"		<span class=\"message-date\"> " + elapsedTime + " </span>" + Environment.NewLine +
						"		<span class=\"message-content\">" + Environment.NewLine +
						"			" + post.Post + Environment.NewLine +
						"		</span>" + Environment.NewLine +
						"	</div>" + Environment.NewLine +
						"</div>" + Environment.NewLine;
		}
		
		context.Response.Write(postHTML);
	}

	public bool IsReusable {get{return false;}}

}
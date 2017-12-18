using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Account_UserControls_ReliefStream : System.Web.UI.UserControl
{
	public string infinateScrollPageSize = ConfigurationManager.AppSettings["InfinatePostScrollPageSize"].ToString();

	protected void Page_Load(object sender, EventArgs e)
	{
		//LoadPosts();
	}
	public void LoadPosts()
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var posts = from rp in dc.RebuildPosts
					join p in dc.Profiles on rp.UserId equals p.UserId
					join uo in dc.UserOrganizations on p.UserId equals uo.UserId
					join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
					orderby rp.CreatedOn descending
					where uo.IsPrimary == true
					select new { o.Name, Logo = ("/Images/Organizations/" + o.Logo), p.ProfileId, rp.Post, rp.CreatedOn, fullname = p.Firstname + " " + p.Lastname, ProfilePhoto = (p.Photo == null ? "Avatar.png" : p.Photo) };

		rptPosts.DataSource = posts;
		rptPosts.DataBind();
	}
}
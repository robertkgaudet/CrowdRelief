using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_UserControls_NavigationOrganization : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		//Get the primary organization for this user.
		if(HttpContext.Current.User.Identity.IsAuthenticated)
		{
			Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var organization = (from uo in dc.UserOrganizations
							   join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
							   where uo.UserId == userId
							   && uo.IsPrimary == true
							   select new { o.Name, o.OrganizationId, o.Logo, o.PrimaryPhone }).SingleOrDefault();


			if(organization != null)
			{
				imgLogo.ImageUrl = "/Images/Organizations/" + organization.Logo;
				litOrganization.Text = organization.Name;

			}
		}

	}
}
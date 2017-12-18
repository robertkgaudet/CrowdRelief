using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_MasterPages_SecureUser : BaseMasterPage
{
	protected void Page_Load(object sender, EventArgs e)
	{
		//Check and make sure the user is assigned a primary rebuild organization.
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		var userOrganization = from uo in dc.UserOrganizations
								where uo.UserId == userId
								&& uo.IsPrimary == true
								select new { uo.OrganizationId };

		if(userOrganization == null)
		{
			Response.Write("User has not been assigned to a primary organization. Please contact an admin before proceeding.");
			Response.End();
		}
	}
}

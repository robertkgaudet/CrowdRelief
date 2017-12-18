using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_UserControls_CollaboratorImageList : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
		var collaboratingOrganizations = from o in dc.Organizations
										 where o.IsActive == true
										 select new { o.Name, o.Logo, o.OrganizationId };

		rptCollaborators.DataSource = collaboratingOrganizations;
		rptCollaborators.DataBind();
	}
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_UserControls_Footer : System.Web.UI.UserControl
{
	protected void Page_Load(object sender, EventArgs e)
	{
		CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

		var partnerOrganizations = from o in dc.Organizations
								   where o.IsActive == true
								   select new { o.Logo, o.YouTubeURL };

		dlPartners.DataSource = partnerOrganizations;
		dlPartners.DataBind();
	}


	protected void dlPartners_ItemDataBound(object sender, DataListItemEventArgs e)
	{
		DataListItem dataItem = (DataListItem)e.Item;
		Image imgPartners = (Image)e.Item.FindControl("imgPartners");
		HyperLink hypPartners = (HyperLink)e.Item.FindControl("hypPartners");
		String logo = (String)DataBinder.Eval(dataItem.DataItem, "Logo");
		String website = (String)DataBinder.Eval(dataItem.DataItem, "YouTubeURL");

		imgPartners.ImageUrl = "~/Images/Organizations/" + logo;
		hypPartners.NavigateUrl = "http://" + website;
	}
}
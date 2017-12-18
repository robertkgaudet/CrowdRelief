using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CrowdRelief
{ 
	public partial class Administration_Default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Master.ShowNeedsButton = false;
			Master.HideTimeControls = true;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var profiles = from s in dc.Profiles
						   join m in dc.aspnet_Memberships on s.UserId equals m.UserId
						   orderby m.CreateDate
							select s;

			dlVolunteers.DataSource = profiles;
			dlVolunteers.DataBind();
		}

		protected void dlVolunteers_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();

				RepeaterItem dataItem = (RepeaterItem)e.Item;
				HtmlGenericControl divGridClick = (HtmlGenericControl)e.Item.FindControl("divGridClick");
				Label lblFirstname						= (Label)e.Item.FindControl("lblFirstname");
				Label lblLastname						= (Label)e.Item.FindControl("lblLastname");
				Label lblPhonenumber					= (Label)e.Item.FindControl("lblPhonenumber");
				//Label lblDescription					= (Label)e.Item.FindControl("lblDescription");
				//Label lblDatesAvailable					= (Label)e.Item.FindControl("lblDatesAvailable");
				//Label lblPreviousVolunteerExperience	= (Label)e.Item.FindControl("lblPreviousVolunteerExperience");
				//Label lblNumberOfDaysAvailable			= (Label)e.Item.FindControl("lblNumberOfDaysAvailable");
					
				//Total count of items and total cost.
				String firstname = (String)DataBinder.Eval(dataItem.DataItem, "firstname");
				String lastname = (String)DataBinder.Eval(dataItem.DataItem, "lastname");
				String phonenumber = (String)DataBinder.Eval(dataItem.DataItem, "phonenumber");
				String description = (String)DataBinder.Eval(dataItem.DataItem, "description");
				String datesAvailable = (String)DataBinder.Eval(dataItem.DataItem, "datesAvailable");
				String previousVolunteerExperience = (String)DataBinder.Eval(dataItem.DataItem, "previousVolunteerExperience");
				String numberOfDaysAvailable = (String)DataBinder.Eval(dataItem.DataItem, "numberOfDaysAvailable");

				lblFirstname.Text = firstname;
				lblLastname.Text = lastname;
				lblPhonenumber.Text = phonenumber;

			}
		}
	}
}
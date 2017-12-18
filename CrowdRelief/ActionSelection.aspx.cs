using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class ActionSelection : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		if (User.Identity.IsAuthenticated)
		{
			string interactionType = Request.QueryString["interactionType"];

			switch (interactionType.ToLower())
			{
				case "help":
					Response.Redirect("Account/BasicNeedsSurvey.aspx");
					break;
				case "volunteer":
					Response.Redirect("Account/Volunteer.aspx");
					break;
				case "items":
					Response.Redirect("Account/Items.aspx");
					break;
				case "organization":
					Response.Redirect("Account/Organization.aspx");
					break;
				case "transportation":
					Response.Redirect("Account/Transportation.aspx");
					break;
			}

			//Redirect to their action selection page.
			Response.Redirect("/ActionSelection.aspx?interactionType=" + Request.QueryString["interactionType"]);
		}
	}
}
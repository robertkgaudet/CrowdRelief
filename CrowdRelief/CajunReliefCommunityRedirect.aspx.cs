using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{ 
	public partial class CajunReliefCommunityRedirect : BaseWebForm
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Master.HideTimeControls = true;
			Master.ShowNeedsButton = false;
			Master.ShowSmallFooter = true;
			SetFacebookMetaTags("ClickToJoin.png", pageURL, "JOIN the Cajun Relief Community on Facebook!");
			
			//Response.Redirect("");
		}
	}
}
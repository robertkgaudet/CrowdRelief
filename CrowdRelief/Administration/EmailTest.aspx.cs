using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{

	public partial class Administration_EmailTest : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Master.HideTimeControls = true;
			Master.ShowNeedsButton = false;
		}

		protected void btnEmailTest_Click(object sender, EventArgs e)
		{
			Tools.SendEmailTemplate("Rob", "Gaudet", txtEmail.Text, txtMessage.Text, "CrowdRelief Test Donate Email", "~\\EmailTemplates\\BaseEmailTemplate.html", this);
		}
	}
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class Login : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			divError.Visible = false;
			if (Membership.ValidateUser(txtUsername.Text, txtPassword.Text))
				FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
			else
				litError.Text = "Please check your user name and password and try again.";
				divError.Visible = true;
		}
	}
}
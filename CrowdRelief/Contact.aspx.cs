using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class Contact : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
		}
	}
}
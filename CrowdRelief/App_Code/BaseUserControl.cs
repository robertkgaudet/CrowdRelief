using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

/// <summary>
/// Summary description for BaseUserControl
/// </summary>
public class BaseUserControl : System.Web.UI.UserControl
{
	private Guid m_userId;
	public BaseUserControl()
	{
		if (HttpContext.Current.User.Identity.IsAuthenticated)
		{
			m_userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
		}
	}

	public Guid userId
	{
		get
		{ return m_userId; }
		set
		{ m_userId = value; }
	}
}
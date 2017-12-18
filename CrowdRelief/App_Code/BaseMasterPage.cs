using System;
using System.Web;
using System.Linq;
using System.Web.Security;
using System.Collections.Generic;

/// <summary>
/// Summary description for BaseOrganizationMasterPage
/// </summary>
public class BaseMasterPage : System.Web.UI.MasterPage
{
	public BaseMasterPage()
	{
		if (HttpContext.Current.User.Identity.IsAuthenticated)
		{
			if(Membership.GetUser() != null)
			{ 
				m_userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
			}
			else
			{
				if (HttpContext.Current.Session != null)
				{
					HttpContext.Current.Session.Abandon();
				}

				FormsAuthentication.SignOut();
			}
		}
	}
	
	private Guid m_userId;
	public Guid userId
	{
		get
		{ return m_userId; }
		set
		{ m_userId = value; }
	}
}
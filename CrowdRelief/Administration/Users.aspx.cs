using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net.Mail;
using System.Collections.Specialized;

namespace CrowdRelief
{ 
	public partial class Administration_Users : System.Web.UI.Page
	{
		string usersOnline = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			string organizationID = string.Empty;
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;

			if (!IsPostBack)
			{
				if (User.IsInRole("SuperAdministrator"))
				{
				}
				else
				{
					LoadOrganizations();
					trOrganization.Visible = true;
					trOrganizationMsg.Visible = true;

					//Guid userId = new Guid(System.Web.Security.Membership.GetUser().ProviderUserKey.ToString());
					//CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
					////use the logged in users organization id.
					//var user = (from u in dc.Profiles
					//			join uo in dc.UserOrganizations on u.UserId equals uo.UserId
					//			where u.UserId == userId
					//			select new { uo.OrganizationId }).SingleOrDefault();

					//if (user != null)
					//{
					//	hidOrganizationId.Value = user.OrganizationId.ToString();
					//	organizationID = user.OrganizationId.ToString();
					//}
				}
				LoadRoles();
				GetUsers(organizationID);
			}
		}

		private void LoadOrganizations()
		{
			//Load the Organization Drop Down List
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var organizations = from o in dc.Organizations
						  orderby o.Name
						  select new { o.OrganizationId, o.Name, o.CreatedOn };

			cblOrganizations.DataSource = organizations;
			cblOrganizations.DataBind();
		}

		private void GetUsers(string organizationId)
		{
			//CHANGE THIS SO THE USERS SELECTION IS FROM LINQ

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			if (!string.IsNullOrEmpty(organizationId))
			{
				//For a specific organization user.
				var users = from p in dc.Profiles
							join a in dc.aspnet_Users on p.UserId equals a.UserId
							join up in dc.UserOrganizations on p.UserId equals up.UserId
							join m in dc.aspnet_Memberships on up.UserId equals m.UserId
							join o in dc.Organizations on up.OrganizationId equals o.OrganizationId
							where up.OrganizationId == new Guid(organizationId)
							orderby a.LastActivityDate descending
							select new { fullname = p.Firstname + " " + p.Lastname, a.UserName, a.LastActivityDate, CreatedOn = m.CreateDate, up.UserId };

				dlUsers.DataSource = users;
				dlUsers.DataBind();
			}
			else
			{
				//Show all users to the system administrator
				var users = from p in dc.Profiles
							join a in dc.aspnet_Users on p.UserId equals a.UserId
							join m in dc.aspnet_Memberships on a.UserId equals m.UserId
							orderby a.LastActivityDate descending
							select new { fullname = p.Firstname + " " + p.Lastname, a.UserName, a.LastActivityDate, CreatedOn = m.CreateDate, a.UserId };

				dlUsers.DataSource = users;
				dlUsers.DataBind();
			}
			usersOnline = Membership.GetNumberOfUsersOnline().ToString();
			//UsersOnlineLabel.Text = Membership.GetNumberOfUsersOnline().ToString();
		}


		public void divUser_Click(object sender, EventArgs args)
		{
			LinkButton divUser = (LinkButton)sender;

			Context.Items.Add("userName", divUser.Attributes["userName"].ToString());
			Server.Transfer("~/Administration/UserDetail.aspx");
		}

		public void CreateUser_OnClick(object sender, EventArgs args)
		{
			// Create new user and retrieve create status result.

			MembershipCreateStatus status;
			string passwordQuestion = "What time is lunch?";
			string passwordAnswer = "12:00";

			if (Membership.RequiresQuestionAndAnswer)
			{
				passwordQuestion = PasswordQuestionTextbox.Text;
				passwordAnswer = PasswordAnswerTextbox.Text;
			}

			try
			{
				MembershipUser newUser = Membership.CreateUser(UsernameTextbox.Text, PasswordTextbox.Text,
															   EmailTextbox.Text, passwordQuestion,
															   passwordAnswer, true, out status);
				if (newUser == null)
				{
					Msg.Text = GetErrorMessage(status);
				}
				else
				{
					//User added
					foreach (ListItem checkBoxItem in cblRoles.Items)
					{
						if (checkBoxItem.Selected)
						{
							//Set the role.
							Roles.AddUserToRole(newUser.UserName, checkBoxItem.Text);
						}
					}

					//Create a profile record for them as well.
					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
					Profile userProfile = new Profile();
					userProfile.Firstname = txtFirstname.Text;
					userProfile.Lastname = txtLastname.Text;
					userProfile.ProfileId = Guid.NewGuid();
					userProfile.UserId = new Guid(newUser.ProviderUserKey.ToString());
					dc.Profiles.InsertOnSubmit(userProfile);
					dc.SubmitChanges();
					
					foreach(ListItem checkBoxItem in cblOrganizations.Items)
					{
						if(checkBoxItem.Selected)
						{
							AddUserToOrganization(checkBoxItem.Value, newUser.ProviderUserKey.ToString());
						}
					}

					SendNewUserEmail();

					Response.Redirect("~/Administration/Users.aspx");
				}
			}
			catch (Exception ex)
			{
				Msg.Text = ex.Message;
			}
		}

		public void AddUserToOrganization(string organizationId, string newUserId)
		{
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			UserOrganization userOrganization = new UserOrganization();
			userOrganization.UserOrganizationId = Guid.NewGuid();
			userOrganization.OrganizationId = new Guid(organizationId);
			userOrganization.UserId = new Guid(newUserId);
			dc.UserOrganizations.InsertOnSubmit(userOrganization);
			dc.SubmitChanges();
		}

		public string GetErrorMessage(MembershipCreateStatus status)
		{
			switch (status)
			{
				case MembershipCreateStatus.DuplicateUserName:
					return "Username already exists. Please enter a different user name.";

				case MembershipCreateStatus.DuplicateEmail:
					return "A username for that e-mail address already exists. Please enter a different e-mail address.";

				case MembershipCreateStatus.InvalidPassword:
					return "The password provided is invalid. Please enter a valid password value.";

				case MembershipCreateStatus.InvalidEmail:
					return "The e-mail address provided is invalid. Please check the value and try again.";

				case MembershipCreateStatus.InvalidAnswer:
					return "The password retrieval answer provided is invalid. Please check the value and try again.";

				case MembershipCreateStatus.InvalidQuestion:
					return "The password retrieval question provided is invalid. Please check the value and try again.";

				case MembershipCreateStatus.InvalidUserName:
					return "The user name provided is invalid. Please check the value and try again.";

				case MembershipCreateStatus.ProviderError:
					return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

				case MembershipCreateStatus.UserRejected:
					return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

				default:
					return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
			}
		}
		protected void LoadRoles()
		{
			string[] roles = Roles.GetAllRoles();
			var rolesList = roles.ToList();
			rolesList.Remove("SuperAdministrator");
			cblRoles.DataSource = rolesList;
			cblRoles.DataBind();

			foreach (string role in roles)
			{
				ListItem currentCheckBox = cblRoles.Items.FindByValue(role);
				if (currentCheckBox != null)
				{
					if (currentCheckBox.Text.ToLower() == "member")
						currentCheckBox.Selected = true;
					currentCheckBox.Attributes.Add("disabled", "disabled");
				}
			}

		}
		protected void SendNewUserEmail()
		{
			string emailFrom = ConfigurationManager.AppSettings["emailFrom"].ToString();
			string emailFromDisplayName = ConfigurationManager.AppSettings["emailFromDisplayName"].ToString();

			ListDictionary ldEmailBodyReplacements = new ListDictionary();
			ldEmailBodyReplacements.Add("<%Firstname%>", txtFirstname.Text);
			ldEmailBodyReplacements.Add("<%Lastname%>", txtLastname.Text);
			ldEmailBodyReplacements.Add("<%Username%>", UsernameTextbox.Text);
			ldEmailBodyReplacements.Add("<%Password%>", PasswordTextbox.Text);

			MailAddress fromAddress = new MailAddress(emailFrom, emailFromDisplayName);

			MailDefinition mailDefinition = new MailDefinition();
			mailDefinition.BodyFileName = Server.MapPath("~\\CreateAccount.html");
			mailDefinition.Subject = "Your CrowdRelief Account Information";
			mailDefinition.IsBodyHtml = true;

			MailMessage newUserMailMessage = mailDefinition.CreateMailMessage(EmailTextbox.Text, ldEmailBodyReplacements, this);

			//newUserMailMessage.Subject = "Your IntellectRX Account Information";
			//newUserMailMessage.IsBodyHtml = true;

			SmtpClient smtp = new SmtpClient();
			smtp.EnableSsl = true;
			smtp.Send(newUserMailMessage);
		}

		protected void dlUsers_ItemDataBound(object sender, DataListItemEventArgs e)
		{

			DataListItem dataItem = (DataListItem)e.Item;
			Label lblRoles = (Label)e.Item.FindControl("lblRoles");
			Label lblCreatedOn = (Label)e.Item.FindControl("lblCreatedOn");
			Label lblLastActivityDate = (Label)e.Item.FindControl("lblLastActivityDate");
			DataList dlOrganizations = (DataList)e.Item.FindControl("dlOrganizations");


			if (DataBinder.Eval(dataItem.DataItem, "CreatedOn") != null)
			{
				DateTime createdOn = (DateTime)DataBinder.Eval(dataItem.DataItem, "CreatedOn");
				createdOn = DateTime.SpecifyKind(createdOn, DateTimeKind.Utc).ToLocalTime();
				lblCreatedOn.Text = createdOn.ToShortDateString() + "</br>" + createdOn.ToShortTimeString();
			}
			if (DataBinder.Eval(dataItem.DataItem, "LastActivityDate") != null)
			{
				DateTime lastActivityDate = (DateTime)DataBinder.Eval(dataItem.DataItem, "LastActivityDate");
				lastActivityDate = DateTime.SpecifyKind(lastActivityDate, DateTimeKind.Utc).ToLocalTime();
				lblLastActivityDate.Text = lastActivityDate.ToShortDateString() + "</br>" + lastActivityDate.ToShortTimeString();
			}

			//Load their organizations.

			if (DataBinder.Eval(dataItem.DataItem, "userId") != null)
			{
				Guid userId = (Guid)DataBinder.Eval(dataItem.DataItem, "userId");

				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				var organizations = from o in dc.Organizations
						   join uo in dc.UserOrganizations on o.OrganizationId equals uo.OrganizationId
						   where uo.UserId == userId
						   select new { o.Name, o.OrganizationId };

				dlOrganizations.DataSource = organizations;
				dlOrganizations.DataBind();
			}

			if (lblRoles != null)
			{
				//Get the roles
				string roleList = string.Empty;
				string username = (string)DataBinder.Eval(dataItem.DataItem, "UserName");

				string[] roles = Roles.GetRolesForUser(username);

				//foreach (string role in roles)
				//{
				//	roleList += roleList + ", ";
				//            }

				lblRoles.Text = "Roles: " + string.Join(", ", roles);
			}


		}

		protected void dlOrganizations_ItemDataBound(object sender, DataListItemEventArgs e)
		{
			DataListItem dataItem = (DataListItem)e.Item;
			Guid organizationId = (Guid)DataBinder.Eval(dataItem.DataItem, "organizationId");
			string organizationName = (string)DataBinder.Eval(dataItem.DataItem, "Name");

			HyperLink hypOrganization = (HyperLink)e.Item.FindControl("hypOrganization");

			hypOrganization.Text = organizationName;
			hypOrganization.NavigateUrl = "~/Manage/OrganizationDetail.aspx?organizationId=" + organizationId.ToString();
		}
	}
}

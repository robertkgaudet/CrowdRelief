using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace CrowdRelief
{ 
	public partial class Administration_UserDetail : System.Web.UI.Page
	{
		string _selectedEmployeeUsername;

		public string SelectedEmployeeUsername
		{
			get
			{
				return _selectedEmployeeUsername;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;

			if (!IsPostBack)
			{
				if (Context.Items["userName"] != null)
				{
					Guid userId = new Guid(System.Web.Security.Membership.GetUser(Context.Items["userName"].ToString()).ProviderUserKey.ToString());

					//Get firstname/lastname
					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

					var userProfile = (from up in dc.Profiles
									   where up.UserId == userId
									   select new { up.Firstname, up.Lastname }).SingleOrDefault();

					if (userProfile != null)
					{
						txtFirstname.Text = userProfile.Firstname;
						txtLastname.Text = userProfile.Lastname;
					}

					LoadOrganizations(userId);
					LoadRoles(Context.Items["userName"].ToString());
					_selectedEmployeeUsername = Context.Items["userName"].ToString();
					MembershipUser currentUser = Membership.GetUser(_selectedEmployeeUsername);
					hidUserId.Value = _selectedEmployeeUsername;
					txtEmail.Text = currentUser.Email;
					chkEnableAccount.Checked = currentUser.IsApproved;
					lblUsername.Text = currentUser.UserName;
					lbDeleteUser.Attributes.Add("onclick", "return confirm('Permanantly Delete This User Account & All Their Data?');");
					lblDateAccountCreated.Text = currentUser.CreationDate.ToLongDateString() + " " + currentUser.CreationDate.ToLongTimeString();

					string lastLoginDate = "Never logged in.";
					if (currentUser.LastLoginDate.Year > 2013)
					{
						lastLoginDate = currentUser.LastLoginDate.ToLongDateString() + " " + currentUser.LastLoginDate.ToLongTimeString();
					}


					lblDateLastLoggedIn.Text = lastLoginDate;
					lblDateOfLastActivity.Text = currentUser.LastActivityDate.ToLongDateString() + " " + currentUser.LastActivityDate.ToLongTimeString();

					string lastLockoutDate = "Never locked out.";
					if (currentUser.LastLockoutDate.Year > 2013)
					{
						lastLockoutDate = currentUser.LastLockoutDate.ToLongDateString() + " " + currentUser.LastLockoutDate.ToLongTimeString();
					}

					lblDateOfLastLockout.Text = lastLockoutDate;
					lblDatePasswordChanged.Text = currentUser.LastPasswordChangedDate.ToLongDateString() + " " + currentUser.LastPasswordChangedDate.ToLongTimeString();
					lblIsApproved.Text = currentUser.IsApproved.ToString();
					lblIsLockedOut.Text = currentUser.IsLockedOut.ToString();
					lblIsUserOnline.Text = currentUser.IsOnline.ToString();
				}
				else
				{
					tblUserDetail.Visible = false;
					lblPageMessage.Text = "PAGE ERROR: User id not passed in context.";
					lblPageMessage.CssClass = "PageMessageRed";
				}
			}
		}
		
		private void LoadOrganizations(Guid userId)
		{
			//Load the Organization Drop Down List
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var organizations = from o in dc.Organizations
								orderby o.Name
								select o;

			cblOrganizations.DataSource = organizations;
			cblOrganizations.DataBind();
			
			foreach (var organization in organizations)
			{
				var userOrganization = from uo in dc.UserOrganizations
									   where uo.OrganizationId == organization.OrganizationId
									   && uo.UserId == userId
									   select uo;
				
				if (userOrganization.Count() > 0)
				{
					ListItem currentCheckBox = cblOrganizations.Items.FindByValue(organization.OrganizationId.ToString());
					if (currentCheckBox != null)
					{
						currentCheckBox.Selected = true;
					}
				}
			}


			var userOrganizations = from uo in dc.UserOrganizations
									join o in dc.Organizations on uo.OrganizationId equals o.OrganizationId
									where uo.UserId == userId
									select new { o.OrganizationId, o.Name };

			ddlPrimaryOrg.DataSource = userOrganizations;
			ddlPrimaryOrg.DataBind();

			//Get the current default if there is one.
			var defaultUserOrg = (from uo in dc.UserOrganizations
								 where uo.UserId == userId && uo.IsPrimary == true
								 select new { uo.OrganizationId }).SingleOrDefault();

			if (defaultUserOrg != null)
			{ 
				ddlPrimaryOrg.SelectedValue = defaultUserOrg.OrganizationId.ToString();
			}
		}

		//protected void dlOrganizations_ItemDataBound(object sender, DataListItemEventArgs e)
		//{
		//	DataListItem dataItem = (DataListItem)e.Item;
		//	Guid organizationId = (Guid)DataBinder.Eval(dataItem.DataItem, "organizationId");
		//	string organizationName = (string)DataBinder.Eval(dataItem.DataItem, "Name");
		//	Guid userId = (Guid)DataBinder.Eval(dataItem.DataItem, "userId");

		//	HyperLink hypOrganization = (HyperLink)e.Item.FindControl("hypOrganization");

		//	hypOrganization.Text = organizationName;
		//	hypOrganization.NavigateUrl = "~/Manage/OrganizationDetail.aspx?organizationId=" + organizationId.ToString();

		//}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			string password = txtPassword.Text;
			string confirmPassword = txtConfirmPassword.Text;
			string currentUserName = hidUserId.Value;
			Guid _userId = new Guid(System.Web.Security.Membership.GetUser(currentUserName).ProviderUserKey.ToString());


			MembershipUser currentUser = Membership.GetUser(currentUserName);
			currentUser.Email = txtEmail.Text;
			currentUser.IsApproved = chkEnableAccount.Checked;
			if (!string.IsNullOrEmpty(password) && !string.IsNullOrEmpty(confirmPassword))
			{
				if (password == confirmPassword)
				{
					currentUser.ChangePassword(currentUser.ResetPassword(), password);
				}
			}
			Membership.UpdateUser(currentUser);



			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var userProfileItem = (from up in dc.Profiles
								   where up.UserId == _userId
								   select up).SingleOrDefault();

			if (userProfileItem != null)
			{
				userProfileItem.Firstname = txtFirstname.Text;
				userProfileItem.Lastname = txtLastname.Text;
				dc.SubmitChanges();
			}
			else
			{
				Profile newUserProfile = new Profile();
				newUserProfile.UserId = _userId;
				newUserProfile.ProfileId = Guid.NewGuid();
				newUserProfile.Lastname = txtLastname.Text;
				newUserProfile.Firstname = txtFirstname.Text;
				dc.Profiles.InsertOnSubmit(newUserProfile);
				dc.SubmitChanges();
			}

			string primaryOrgId = ddlPrimaryOrg.SelectedValue;

			if(String.IsNullOrEmpty(primaryOrgId))
			{
				primaryOrgId = "79305F85-3816-46A8-911F-0D7E3E227C32";
			}

			Guid defaultLocationId = new Guid(primaryOrgId);

			//Update orgs
			foreach (ListItem checkBoxItem in cblOrganizations.Items)
			{
				Guid organizationId = new Guid(checkBoxItem.Value);

				var userOrganization = (from uo in dc.UserOrganizations
									   where uo.OrganizationId == organizationId
									   && uo.UserId == _userId
									   select uo).SingleOrDefault();
				
				if (checkBoxItem.Selected)
				{
					//Find out if the user is in the org, if not, add them.
					if (userOrganization == null)
					{
						UserOrganization userOrg = new UserOrganization();
						//Add to this table
						userOrg.UserOrganizationId = Guid.NewGuid();
						userOrg.UserId = _userId;
						userOrg.OrganizationId = organizationId;

						if(defaultLocationId == organizationId)
						{
							//Is this the defauit location?
							userOrg.IsPrimary = true;
						}
						else
						{
							userOrg.IsPrimary = false;
						}

						dc.UserOrganizations.InsertOnSubmit(userOrg);
						dc.SubmitChanges();
					}
					else
					{
						//make sure this is the primary location
						//Is this the defauit location?
						if (checkBoxItem.Value == defaultLocationId.ToString())
						{
							userOrganization.IsPrimary = true;
							dc.SubmitChanges();
						}
						else
						{
							userOrganization.IsPrimary = false;
							dc.SubmitChanges();
						}
					}

				}
				else
				{
					//If user is in the org, remove them.
					if (userOrganization != null)
					{
						dc.UserOrganizations.DeleteOnSubmit(userOrganization);
						dc.SubmitChanges();
					}
				}
			}

			//Update roles
			foreach (ListItem checkBoxItem in cblRoles.Items)
			{
				if (checkBoxItem.Selected)
				{
					//If user is not in the role, add them to it.
					if (!Roles.IsUserInRole(currentUserName, checkBoxItem.Text))
					{
						Roles.AddUserToRole(currentUserName, checkBoxItem.Text);
					}
				}
				else
				{
					//Not selected roles.
					if (Roles.IsUserInRole(currentUserName, checkBoxItem.Text))
					{
						Roles.RemoveUserFromRole(currentUserName, checkBoxItem.Text);
					}
				}
			}


			


			lblPageMessage.Text = "User account updated.";
			lblPageMessage.CssClass = "PageMessageGreen";
		}

		protected void lbDeleteUser_Click(object sender, EventArgs e)
		{
			string currentUserName = hidUserId.Value;
			//Delete profile record
			//Delete report record



			bool userDeleted = Membership.DeleteUser(currentUserName);
			if (userDeleted)
			{
				lblPageMessage.Text = "User account deleted.";
				lblPageMessage.CssClass = "PageMessageRed";
				tblUserDetail.Visible = false;
				hypReturnOnDelete.Visible = true;
			}
			else
			{
				lblPageMessage.Text = "User account was unable to be deleted, please contact support.";
				lblPageMessage.CssClass = "PageMessageRed";
			}
		}

		protected void LoadRoles(string username)
		{
			Array roles = Roles.GetAllRoles();
			Array userRoles = Roles.GetRolesForUser(username);

			cblRoles.DataSource = roles;
			cblRoles.DataBind();

			//Loop through user roles.
			foreach (string userRole in userRoles)
			{
				//Loop through all roles
				foreach (string role in roles)
				{
					if (role == userRole)
					{
						ListItem currentCheckBox = cblRoles.Items.FindByValue(role);
						if (currentCheckBox != null)
						{
							currentCheckBox.Selected = true;
						}
					}
				}
			}

		}
	}
}
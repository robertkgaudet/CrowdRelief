using System;
using System.Linq;
using System.Web.Security;

namespace CrowdRelief
{
	public partial class Register : BaseWebForm
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			if (User.Identity.IsAuthenticated)
			{
				//Redirect to their action selection page.
				Response.Redirect("/ActionSelection.aspx?interactionType=" + Request.QueryString["interactionType"]);
			}

			divError.Visible = false;

			string need = Request.QueryString["interactionType"];

			if (!String.IsNullOrEmpty(need))
			{
				switch (need.ToLower())
				{
					case "help":
						SetFacebookMetaTags("Facebook-Map.jpg", pageURL, "Get Help From CrowdRelief - Flood victimsThose with household needs that the would like to have replaced by creating a crowdfunding campaign");
						Page.Title = "Get Help From CrowdRelief - Flood victimsThose with household needs that the would like to have replaced by creating a crowdfunding campaign";
						litType.Text = " with ";
						btnSubmit.Text = "Register for Help";
						break;
					case "volunteer":
						SetFacebookMetaTags("Facebook-Map.jpg", pageURL, "Volunteer for CrowdRelief - Case workers, photographers and writers needed to help Louisiana flood victims recover");
						Page.Title = "Volunteer for CrowdRelief - Case workers, photographers and writers needed to help Louisiana flood victims recover";
						litType.Text = " to volunteer for the Cajun Relief Foundation through ";
						btnSubmit.Text = "Register to Volunteer for Irma";
						break;
					case "items":
						litType.Text = " to donate items through ";
						btnSubmit.Text = "Register to Donate";
						break;
					case "organization":
						litType.Text = " to add your organization to ";
						btnSubmit.Text = "Register to Add Your Organization";
						break;
					case "transportation":
						litType.Text = " to volunteer transportation to ";
						btnSubmit.Text = "Register to Volunteer Transportation";
						break;
				}
			}
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			MembershipCreateStatus status;
			string passwordQuestion = "What time is lunch?";
			string passwordAnswer = "12:00";

			MembershipUser newUser = Membership.CreateUser(txtUsername.Text, txtPassword.Text, txtEmail.Text, passwordQuestion, passwordAnswer, true, out status);

			if (newUser == null)
			{
				litError.Text = GetErrorMessage(status);
				divError.Visible = true;
			}
			else
			{
				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				Roles.AddUserToRole(txtUsername.Text, "Member");

				//Create a profile for this user.
				Profile userProfile = new Profile();
				userProfile.ProfileId = Guid.NewGuid();
				userProfile.Firstname = txtFirstName.Text;
				userProfile.Lastname = txtLastName.Text;
				userProfile.PhoneNumber = txtPhoneNumber.Text;
				userProfile.Address = txtAddress.Text;
				userProfile.City = txtCity.Text;
				userProfile.State = txtState.Text;
				userProfile.Zip = txtZipCode.Text;
				userProfile.UserId = new Guid(newUser.ProviderUserKey.ToString());
				dc.Profiles.InsertOnSubmit(userProfile);
				dc.SubmitChanges();

				//Lookup InteractionTypeId
				var interactionTypeId = (from c in dc.InteractionTypes
										 where c.Lookup == Request.QueryString["interactionType"]
										 select c).SingleOrDefault();

				UserInteractionType userInteractionType = new UserInteractionType();
				userInteractionType.UserInteractionTypeId = Guid.NewGuid();
				userInteractionType.UserId = new Guid(newUser.ProviderUserKey.ToString());
				userInteractionType.InteractionTypeId = interactionTypeId.InteractionTypeId;
				dc.UserInteractionTypes.InsertOnSubmit(userInteractionType);
				dc.SubmitChanges();
				
				Tools.SendEmail(txtFirstName.Text, txtLastName.Text, "~\\CreateAccount.html", "Welcome to Crowd Relief", txtEmail.Text, this);
				
				if (!String.IsNullOrEmpty(Request.QueryString["interactionType"]))
				{
					if(Request.QueryString["interactionType"].ToLower() == "volunteer")
					{
						if(User.Identity.IsAuthenticated)
						{
							Response.Redirect("~/account/volunteer.aspx");
						}
						else
						{
							//Log them in
							//FormsAuthentication.Authenticate(txtUsername.Text, txtPassword.Text);
							Response.Redirect("~/account/volunteer.aspx");
						}
					}
					else
					{ 
						FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
					}
				}
				else
				{
					FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
				}
			}
		}

		public string GetErrorMessage(MembershipCreateStatus status)
		{
			switch (status)
			{
				case MembershipCreateStatus.DuplicateUserName:
					return "Username already exists. Please enter a different user name.";

				case MembershipCreateStatus.DuplicateEmail:
					return "A username for that e-mail address already exists. Please sign in with your your email address.";

				case MembershipCreateStatus.InvalidPassword:
					return "The password provided is invalid. Please enter a password with 8 characters that includes a character and a number.";

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
	}
}
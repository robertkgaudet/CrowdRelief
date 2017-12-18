using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class Administration_Organization : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			this.Master.HideTimeControls = true;
			if (!IsPostBack)
			{
				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

				var events = from c in dc.Events
							 where c.IsActive == true && c.IsDisaster == true
							 select c;

				chkBoxList.DataSource = events;
				chkBoxList.DataBind();
			}
		}

		protected void btn_Click(object sender, EventArgs e)
		{
			if (User.Identity.IsAuthenticated)
			{

				Guid organizationId = Guid.NewGuid();

				Organization organization = new Organization();
				organization.Address = txtAddress.Text;
				organization.City = txtCity.Text;
				organization.CreatedBy = new Guid(Membership.GetUser().ProviderUserKey.ToString());
				organization.CreatedOn = DateTime.Now;
				organization.Description = txtOrganizationDetails.Text;
				organization.FacebookURL = txtFacebookURL.Text;
				organization.InstagramURL = txtInstagramUsername.Text;
				organization.Name = txtOrganizationName.Text;
				organization.OrganizationId = organizationId;
				organization.PrimaryPhone = txtPrimaryPhone.Text;
				organization.State = txtState.Text;
				organization.TwitterURL = txtTwitterUsername.Text;
				organization.YouTubeURL = txtYouTubeURL.Text;
				organization.Zip = txtZipCode.Text;

				CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
				dc.Organizations.InsertOnSubmit(organization);
				dc.SubmitChanges();

				string disastersAddressed = string.Empty;

				foreach (ListItem item in chkBoxList.Items)
				{
					OrganizationEvent organizationEvent = new OrganizationEvent();
					if (item.Selected)
					{
						organizationEvent.OrganizationEventId = Guid.NewGuid();
						organizationEvent.EventId = new Guid(item.Value.ToString());
						organizationEvent.OrganizationId = organizationId;
						dc.OrganizationEvents.InsertOnSubmit(organizationEvent);
						dc.SubmitChanges();

						disastersAddressed = disastersAddressed + "<span style='font-size:20px;'>" + item.Text + "</span><br>";
					}
				}

				divFormFields.Visible = false;
				divResults.Visible = true;

				lblOrgName.Text = txtOrganizationName.Text;
				lblResults.Text = "<i>Description: </i>" + txtOrganizationDetails.Text;
				lblEvents.Text = "<i>Disasters: </i><br>" + disastersAddressed;
			}
		}
	}
}
using System;
using System.Linq;
using System.Web.Security;
using Braintree;
using System.Collections.Generic;

namespace CrowdRelief
{

	public partial class Secure_Donate : System.Web.UI.Page
	{
		public string ClientName = string.Empty;

		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.HideTimeControls = true;
			this.Master.ShowNeedsButton = false;
			bool testMode = Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["testMode"].ToString());
			string testNonce = System.Configuration.ConfigurationManager.AppSettings["testNonce"].ToString();
			string testCampaignId = System.Configuration.ConfigurationManager.AppSettings["testCampaignId"].ToString();
			string testBasicSurveyItemId = System.Configuration.ConfigurationManager.AppSettings["testBasicNeedsSurveyItemId"].ToString();

			string campaignId = Request.QueryString["campaignId"];
			string basicSurveyItemId = Request.QueryString["basicSurveyItemId"];
			string clientFirstName = string.Empty;

			divWarning.Visible = false;
			divSuccess.Visible = false;
			divShare.Visible = false;

			if (string.IsNullOrEmpty(campaignId) && testMode)
			{
				campaignId = testCampaignId;
				basicSurveyItemId = testBasicSurveyItemId;
			}

			Guid userId = Guid.NewGuid();
			if (User.Identity.IsAuthenticated)
			{
				userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
			}

			if (!IsPostBack)
			{
				string campaignImageFolder = System.Configuration.ConfigurationManager.AppSettings["CampaignImageFolder"].ToString();

				if (!String.IsNullOrEmpty(campaignId))
				{
					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
					//Get the amount from the item id.

					var campaign = (from c in dc.BasicNeedsCampaigns
									join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
									join sp in dc.SurveyPhotos on s.SurveyId equals sp.SurveyId
									join p in dc.Photos on sp.PhotoId equals p.PhotoId
									join u in dc.Profiles on s.CreatedBy equals u.UserId
									where c.BasicNeedsCampaignId == new Guid(campaignId) && sp.PrimaryCampaignImage == true
									select new
									{
										surveyId = s.SurveyId,
										PhotoFileName = p.Filename,
										clientFirstName = s.FirstName,
										creatorName = u.Firstname + " " + u.Lastname,
										campaignTitle = c.Title
									}).SingleOrDefault();

					if (campaign != null)
					{
						lblCampaignTitle.Text = campaign.campaignTitle;
						lblAmountNeeded.Text = String.Format("{0:C0}", Tools.GetUnmetCosts(campaign.surveyId));
						litClientName.Text = campaign.clientFirstName;
						imgCampaign.ImageUrl = campaignImageFolder + campaign.PhotoFileName;
						clientFirstName = campaign.clientFirstName;
					}

					if (!String.IsNullOrEmpty(basicSurveyItemId))
					{
						//get the amount and the item name.

						var itemInfo = (from bnsi in dc.BasicNeedsSurveyItems
										join i in dc.Items on bnsi.ItemId equals i.ItemId
										where bnsi.BasicSurveyItemId == new Guid(basicSurveyItemId)
										select new { ItemName = i.Name, ItemCount = bnsi.Count, ItemCost = i.Cost }).SingleOrDefault();

						if (itemInfo != null)
						{
							string apostrophe = "";
							string each = "";
							if (itemInfo.ItemCount > 1)
							{
								apostrophe = "'s";
								each = " each";
							}
							litCountMessage.Text = "<div style='text-align:right; display:block;'>" + itemInfo.ItemCount.ToString() + " " + itemInfo.ItemName + apostrophe +" at " + String.Format("{0:C0}", itemInfo.ItemCost) + each + ".</div>";

							hidItemCostEach.Value = itemInfo.ItemCost.ToString();
							hidItemCount.Value = itemInfo.ItemCount.ToString();

							decimal? cost = itemInfo.ItemCost * itemInfo.ItemCount;
							litItemName.Text = itemInfo.ItemName;
							txtAmount.Text = cost.ToString();
							lblItemDescription.Text = "You are donating " + itemInfo.ItemCount.ToString() + " " + itemInfo.ItemName + ". to help " + campaign.clientFirstName + " recover. Increase the amount above to help them recover more quickly.";
						}
					}
				}
			}
			else
			{
				//Postback
				string nonceFromTheClient = hidNonceControl.Value;

				string amountStr = txtAmount.Text;
				string message = string.Empty;

				decimal resultDec;

				if(!String.IsNullOrEmpty(amountStr) && decimal.TryParse(amountStr, out resultDec))
				{
					decimal amountDecimal = decimal.Parse(amountStr);

					BraintreeGateway gateway = new BraintreeGateway();

					if (testMode)
					{
						gateway.Environment = Braintree.Environment.SANDBOX;
						gateway.MerchantId = "bzzxdb3b496mcmg8";
						gateway.PublicKey = "8pt4km256dh5d8xm";
						gateway.PrivateKey = "44c448397615c0dbad22baf364ab1885";
						nonceFromTheClient = testNonce;
					}
					else
					{
						gateway.Environment = Braintree.Environment.PRODUCTION;
						gateway.MerchantId = "2fpmr2kcw3km3q6y";
						gateway.PublicKey = "5xf6jgccdtvzykqq";
						gateway.PrivateKey = "3f036ed0d48a2337b0c702043e32b224";
					}
					
					//Create the client token
					var clientToken = gateway.ClientToken.generate();
				
					var request = new TransactionRequest
					{
						Amount = amountDecimal,
						PaymentMethodNonce = nonceFromTheClient,
						Customer = new CustomerRequest
						{
							Id = userId.ToString(),
							FirstName = txtFirstName.Text,
							LastName = txtLastName.Text,
							Phone = txtPhone.Text,
							Email = txtEmail.Text
						},
						CustomFields = new Dictionary<string, string>
						{
							{ "campaignid", campaignId },
							{ "basicneedssurveyitemid", basicSurveyItemId },
							{ "userid", userId.ToString() },
							{ "itemcount", hidItemCount.Value },
							{ "itemcosteach", hidItemCostEach.Value }
						},
						Options = new TransactionOptionsRequest
						{
							SubmitForSettlement = true
						}
					};

					Result<Transaction> result = gateway.Transaction.Sale(request);
					bool success = result.IsSuccess();

					message = result.Message;

					if (success)
					{
						Dictionary<string, string> keys = result.Target.CustomFields;
						string campaignid = keys["campaignid"];
						string basicneedssurveyitemid = keys["basicneedssurveyitemid"];
						string userid = keys["userid"];

						Transaction transaction = result.Target;

						string transactionId = transaction.Id;
						string orderId = transaction.OrderId;
						decimal? amount = transaction.Amount;
						string authorizedTransactionId = transaction.AuthorizedTransactionId;
						string settlementBatchId = transaction.SettlementBatchId;
						DateTime? createdAt = transaction.CreatedAt;

						//Save in the donation table.

						Donation donation = new Donation();
						donation.Amount = amountDecimal;
						donation.AuthorizedTransactionId = authorizedTransactionId;
						donation.BasicNeedsSurveyItemId = new Guid(basicSurveyItemId);
						donation.CampaignId = new Guid(campaignId);
						donation.CreatedAt = (DateTime) createdAt;
						donation.DonationId = Guid.NewGuid();
						donation.EmailAddress = txtEmail.Text;
						donation.FirstName = txtFirstName.Text;
						donation.IsTest = testMode;
						donation.UserId = userId;
						donation.LastName = txtLastName.Text;
						donation.OrderId = orderId;
						donation.PhoneNumber = txtPhone.Text;
						donation.SettlementBatchId = settlementBatchId;
						donation.ItemCount = int.Parse(hidItemCount.Value);
						donation.ItemCostEach = decimal.Parse(hidItemCostEach.Value);

						CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
						dc.Donations.InsertOnSubmit(donation);
						dc.SubmitChanges();

						divDonationContainer.Visible = false;
						divSuccess.Visible = true;
						divShare.Visible = true;
						lblSuccess.Text = "Thank you for your donation of " + String.Format("{0:C0}", amountDecimal) + ". A receipt for your donation has been emailed to you.";
						hypReturnToCampaign.Text = "Return to Campaign";
						hypReturnToCampaign.NavigateUrl = "/Campaign.aspx?campaignId=" + campaignId;



						//Send thank you email

						var itemInfo = (from bnsi in dc.BasicNeedsSurveyItems
										join i in dc.Items on bnsi.ItemId equals i.ItemId
										where bnsi.BasicSurveyItemId == new Guid(basicSurveyItemId)
										select new { ItemName = i.Name, ItemCount = bnsi.Count, ItemCost = i.Cost }).SingleOrDefault();

						string itemName = "Unknown";
						string clientName = "Unknown";
						if (itemInfo != null)
						{
							itemName = itemInfo.ItemName;
						}

						var campaign = (from c in dc.BasicNeedsCampaigns
										join s in dc.BasicNeedsSurveys on c.BasicNeedsSurveyId equals s.SurveyId
										where c.BasicNeedsCampaignId == new Guid(campaignId)
										select new
										{
											clientFirstName = s.FirstName
										}).SingleOrDefault();

						if(campaign != null)
						{
							clientName = ", " + campaign.clientFirstName;
						}

						string emailMessage = "Thank you for supporting disaster victim" + clientName + " on CrowdRelief.<br/>The information below is your payment reciept.<h3>Payment Reciept</h3>" +
							"<table><tr><td>Amount</td><td>Item</td><td>Recipient</td><td>Date</td><td>Transaction Keys</td></tr>" +
							"<tr><td>$" + amountDecimal  + "</td><td>" + itemName + "s</td><td>Recipient</td><td>" + createdAt.Value.ToShortDateString() + "</td><td>orderId: " + orderId + "<br/>authorizedTransactionId: " + authorizedTransactionId + " <br/>transactionId: " + transactionId + "<br/>campaignid: " + campaignid + "<br/>userid: " + userid + "</td></tr></table>";

						Tools.SendEmailTemplate(txtFirstName.Text, txtLastName.Text, txtEmail.Text, emailMessage, "Your donation to a disaster victim on on CrowdRelief", "~\\EmailTemplates\\BaseEmailTemplate.html", this);
					}
					else
					{
						//Post the error message
						divDonationContainer.Visible = true;
						divWarning.Visible = true;
						lblWarning.Text = result.Message;
					}
				}
				else
				{
					lblWarning.Text = "Invalid amount sent.";
				}
			}
		}
	}
}
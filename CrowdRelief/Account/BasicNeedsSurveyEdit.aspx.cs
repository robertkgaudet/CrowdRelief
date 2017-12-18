using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace CrowdRelief
{
	public partial class BasicNeedsSurveyFormEdit : System.Web.UI.Page
	{
		public string surveyId = string.Empty;
		protected void Page_Load(object sender, EventArgs e)
		{
			this.Master.ShowNeedsButton = false;
			surveyId = Request.QueryString["SurveyId"];

			if(!IsPostBack)
			{ 
				if(!string.IsNullOrEmpty(surveyId))
				{

					//Set some defaults that will get changed later if needed.
					rblDryer.SelectedIndex = rblDryer.Items.IndexOf(rblDryer.Items.FindByText("Don't Need"));
					rblStoveTop.SelectedIndex = rblStoveTop.Items.IndexOf(rblStoveTop.Items.FindByText("Don't Need"));
					rblGroupWaterHeater.SelectedIndex = rblGroupWaterHeater.Items.IndexOf(rblGroupWaterHeater.Items.FindByText("Don't Need"));

					//Get all of the info and load it up.
					CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

					var survey = (from s in dc.BasicNeedsSurveys
								  where s.SurveyId == new Guid(surveyId)
								  select s).SingleOrDefault();

					txtFirstname.Text = survey.FirstName;
					txtLastname.Text = survey.LastName;
				
					txtLossAddress.Text = survey.HomeLossAddress;
					txtLossCity.Text = survey.HomeLossCity;
					txtLossCountyParish.Text = survey.HomeLossParishCounty;
					ddlLossState.SelectedIndex = ddlLossState.Items.IndexOf(ddlLossState.Items.FindByValue(survey.HomeLossState));
				
					txtZipCode.Text = survey.HomeLossZipCode;
					txtPhoneNumber.Text = survey.PhoneNumber;
					txtEmail.Text = survey.EmailAddress;
					txtHelp.Text = survey.HelpDetails;
					txtStory.Text = survey.Story;
					txtFemaNumber.Text = survey.FEMANumber;

					txtPeopleInHome.Text = survey.NumberOfPeopleAffected.ToString();
					txtBedrooms.Text = survey.NumberOfBedrooms.ToString();
					txtBathrooms.Text = survey.NumberOfBathrooms.ToString();

					if (survey.RebuildRepairNeeded)
					{
						rblRebuildRepair.SelectedIndex = rblRebuildRepair.Items.IndexOf(rblRebuildRepair.Items.FindByValue("Yes"));
					}
					else
					{
						rblRebuildRepair.SelectedIndex = rblRebuildRepair.Items.IndexOf(rblRebuildRepair.Items.FindByValue("No"));
					}

					if (survey.ImmediateHousingNeeded)
					{

						rblHousingNeed.SelectedIndex = rblHousingNeed.Items.IndexOf(rblHousingNeed.Items.FindByValue("Yes"));
					}
					else
					{
						rblHousingNeed.SelectedIndex = rblHousingNeed.Items.IndexOf(rblHousingNeed.Items.FindByValue("No"));
					}

					if (survey.SupportAlreadyBeingProvided)
					{
						rblSupportSystem.SelectedIndex = rblSupportSystem.Items.IndexOf(rblSupportSystem.Items.FindByValue("Yes"));
					}
					else
					{
						rblSupportSystem.SelectedIndex = rblSupportSystem.Items.IndexOf(rblSupportSystem.Items.FindByValue("No"));
					}







					var surveyItems = from si in dc.BasicNeedsSurveyItems
									   join i in dc.Items on si.ItemId equals i.ItemId
									   join it in dc.ItemTypes on i.ItemTypeId equals it.ItemTypeId
									   where si.SurveyId == new Guid(surveyId)
									   orderby it.Name
									   select new { Count = si.Count, ItemId = i.ItemId, ItemName = i.Name, Cost = i.Cost, ItemTypeName = it.Name };

					foreach(var si in surveyItems)
					{
						if(si.ItemTypeName == "Window Treatments")
						{ 
							for (int i = 0; i < cblWindowTreatments.Items.Count; i++)
							{
								if (si.ItemName == "Blinds" && cblWindowTreatments.Items[i].Text == "Blinds")
									cblWindowTreatments.Items[i].Selected = true;

								if (si.ItemName == "Curtains" && cblWindowTreatments.Items[i].Text == "Curtains")
									cblWindowTreatments.Items[i].Selected = true;

								if (si.ItemName == "Shades" && cblWindowTreatments.Items[i].Text == "Shades")
									cblWindowTreatments.Items[i].Selected = true;
							}
						}

						if (si.ItemTypeName == "Furniture")
						{
							for (int i = 0; i < cblFurniture.Items.Count; i++)
							{
								if (si.ItemName == "Chair" && cblFurniture.Items[i].Text == "Chair")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Coffee Table" && cblFurniture.Items[i].Text == "Coffee Table")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Couch" && cblFurniture.Items[i].Text == "Couch")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "End Table" && cblFurniture.Items[i].Text == "End Tables")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Love Seat" && cblFurniture.Items[i].Text == "Love Seat")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Lamp" && cblFurniture.Items[i].Text == "Lamps")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Table and Chairs" && cblFurniture.Items[i].Text == "Table and Chairs")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "Rugs" && cblFurniture.Items[i].Text == "Rugs")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "TV" && cblFurniture.Items[i].Text == "TV")
									cblFurniture.Items[i].Selected = true;

								if (si.ItemName == "TV Stand" && cblFurniture.Items[i].Text == "TV Stand")
									cblFurniture.Items[i].Selected = true;
							}
						}

						if (si.ItemTypeName == "Appliance")
						{
							for (int i = 0; i < cblAppliances.Items.Count; i++)
							{
								if (si.ItemName == "Coffee Pot" && cblAppliances.Items[i].Text == "Coffee Pot")
									cblAppliances.Items[i].Selected = true;

								if (si.ItemName == "Refrigerator" && cblAppliances.Items[i].Text == "Refrigerator")
									cblAppliances.Items[i].Selected = true;

								if (si.ItemName == "Washing Machine" && cblAppliances.Items[i].Text == "Washing Machine")
									cblAppliances.Items[i].Selected = true;

								if (si.ItemName == "Dish Washer" && cblAppliances.Items[i].Text == "Dish Washer")
									cblAppliances.Items[i].Selected = true;

								if (si.ItemName == "Toaster" && cblAppliances.Items[i].Text == "Toaster")
									cblAppliances.Items[i].Selected = true;

								if (si.ItemName == "Microwave Oven" && cblAppliances.Items[i].Text == "Microwave Oven")
									cblAppliances.Items[i].Selected = true;
							}
						}

						if (si.ItemTypeName == "Dishes and Utensils")
						{
							for (int i = 0; i < cblUtensils.Items.Count; i++)
							{
								if (si.ItemName == "Cooking Utensils" && cblUtensils.Items[i].Text == "Cooking Utensils")
									cblUtensils.Items[i].Selected = true;

								if (si.ItemName == "Silverware" && cblUtensils.Items[i].Text == "Silverware")
									cblUtensils.Items[i].Selected = true;

								if (si.ItemName == "Pots and Pans" && cblUtensils.Items[i].Text == "Pots and Pans")
									cblUtensils.Items[i].Selected = true;

								if (si.ItemName == "Plates and Bowls" && cblUtensils.Items[i].Text == "Plates and Bowls")
									cblUtensils.Items[i].Selected = true;

								if (si.ItemName == "Plastic Food Storage" && cblUtensils.Items[i].Text == "Plastic Food Storage")
									cblUtensils.Items[i].Selected = true;

								if (si.ItemName == "Cups and Glasses" && cblUtensils.Items[i].Text == "Cups and Glasses")
									cblUtensils.Items[i].Selected = true;
							}
						}

						if (si.ItemTypeName == "Linen")
						{
							for (int i = 0; i < cblLinen.Items.Count; i++)
							{
								if (si.ItemName == "Towels & Washclothes" && cblLinen.Items[i].Text == "Towels & Washclothes")
									cblLinen.Items[i].Selected = true;

								if (si.ItemName == "Sheets & Pillow Cases" && cblLinen.Items[i].Text == "Sheets & Pillow Cases")
									cblLinen.Items[i].Selected = true;

								if (si.ItemName == "Dish Towels" && cblLinen.Items[i].Text == "Dish Towels")
									cblLinen.Items[i].Selected = true;
							}
						}

						if (si.ItemName == "Clothing")
						{
							cbClothing.Checked = true;
						}
					
						if (si.ItemName == "Double Bed")
						{
							txtDoubleBeds.Text = si.Count.ToString();
						}

						if (si.ItemName == "Single Bed")
						{
							txtSingleBeds.Text = si.Count.ToString();
						}

						if (si.ItemName == "Queen Bed")
						{
							txtQueenBeds.Text = si.Count.ToString();
						}

						if (si.ItemName == "Dresser")
						{
							txtDressers.Text = si.Count.ToString();
						}

						if (si.ItemName == "Bed Frame")
						{
							txtBedFrames.Text = si.Count.ToString();
						}

						if (si.ItemName == "Electric Dryer")
						{
							rblDryer.SelectedIndex = rblDryer.Items.IndexOf(rblDryer.Items.FindByText("Electric"));
						}

						if (si.ItemName == "Gas Dryer")
						{
							rblDryer.SelectedIndex = rblDryer.Items.IndexOf(rblDryer.Items.FindByText("Gas"));
						}

						if (si.ItemName == "Electric Stove Top Oven")
						{
							rblStoveTop.SelectedIndex = rblStoveTop.Items.IndexOf(rblStoveTop.Items.FindByText("Electric"));
						}

						if (si.ItemName == "Gas Stove Top Oven")
						{
							rblStoveTop.SelectedIndex = rblStoveTop.Items.IndexOf(rblStoveTop.Items.FindByText("Gas"));
						}

						if (si.ItemName == "Electric Water Heater")
						{
							rblGroupWaterHeater.SelectedIndex = rblGroupWaterHeater.Items.IndexOf(rblGroupWaterHeater.Items.FindByText("Electric"));
						}
						if (si.ItemName == "Gas Water Heater")
						{
							rblGroupWaterHeater.SelectedIndex = rblGroupWaterHeater.Items.IndexOf(rblGroupWaterHeater.Items.FindByText("Gas"));
						}
						
						if (si.ItemName == "Insulation Roles")
						{
							txtInsulation.Text = si.Count.ToString();
						}

						if (si.ItemName == "Sheets of Sheetrock")
						{
							txtSheetRock.Text = si.Count.ToString();
						}
					}
				}
			}
		}

		protected void btnSubmit_Click(object sender, EventArgs e)
		{
			Guid userId = new Guid(Membership.GetUser().ProviderUserKey.ToString());
			DateTime requestTime = DateTime.Now;

			string story = txtStory.Text;
			if (!String.IsNullOrEmpty(story))
			{
				story = story.Replace(System.Environment.NewLine, "<br>");
			}

			string help = txtHelp.Text;
			if (!String.IsNullOrEmpty(help))
			{
				help = help.Replace(System.Environment.NewLine, "<br>");
			}

			//Add BasicNeedsSurvey Info
			bool isHousingNeeded = false;
			string housingNeeded = rblHousingNeed.SelectedValue;
			if (housingNeeded == "Yes")
			{
				isHousingNeeded = true;
			}


			bool isRebuildRepairNeeded = false;
			string rebuildRepairNeeded = rblRebuildRepair.SelectedValue;
			if (rebuildRepairNeeded == "Yes")
			{
				isRebuildRepairNeeded = true;
			}

			bool isSupportSystemProvided = false;
			string supportSystemProvided = rblSupportSystem.SelectedValue;
			if (supportSystemProvided == "Yes")
			{
				isSupportSystemProvided = true;
			}


			Guid surveyId = new Guid(Request.QueryString["SurveyId"]);
			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();
			var survey = (from s in dc.BasicNeedsSurveys
						  where s.SurveyId == surveyId
						  select s).SingleOrDefault();

			survey.UpdatedBy = userId;
			survey.UpdateOn = DateTime.Now;
			survey.EmailAddress = txtEmail.Text;
			if(!string.IsNullOrEmpty(txtFemaNumber.Text))
				survey.FEMANumber = txtFemaNumber.Text;
			survey.HelpDetails = help;
			survey.Story = story;
			survey.FirstName = txtFirstname.Text;
			survey.LastName = txtLastname.Text;
			survey.HomeLossAddress = txtLossAddress.Text;
			survey.HomeLossCity = txtLossCity.Text;
			survey.HomeLossParishCounty = txtLossCountyParish.Text;
			survey.HomeLossState = ddlLossState.SelectedValue;
			survey.HomeLossZipCode = txtZipCode.Text;
			survey.NumberOfBathrooms = Convert.ToInt32(txtBathrooms.Text);
			survey.NumberOfBedrooms = Convert.ToInt32(txtBedrooms.Text);
			survey.NumberOfPeopleAffected = Convert.ToInt32(txtPeopleInHome.Text);
			survey.PhoneNumber = txtPhoneNumber.Text;
			survey.ImmediateHousingNeeded = isHousingNeeded;
			survey.RebuildRepairNeeded = isRebuildRepairNeeded;
			survey.SupportAlreadyBeingProvided = isSupportSystemProvided;
			dc.SubmitChanges();

			Guid clothingNeededGuid = new Guid(cbClothing.Attributes["guid"].ToString());
			var basicNeedsSurveyClothing = (from bnsi in dc.BasicNeedsSurveyItems
											where bnsi.SurveyId == surveyId
											&& bnsi.ItemId == clothingNeededGuid
											select bnsi).SingleOrDefault();

			if (cbClothing.Checked)
			{
				//Clothing checked, but it's not in the database yet.
				if(basicNeedsSurveyClothing == null)
				{
					Guid basicNeedsSurveyItemId = Guid.NewGuid();
					// If the item is selected, add the value to the list.
					BasicNeedsSurveyItem basicNeedsSurveyItem = new BasicNeedsSurveyItem();
					basicNeedsSurveyItem.BasicSurveyItemId = basicNeedsSurveyItemId;
					basicNeedsSurveyItem.SurveyId = surveyId;
					basicNeedsSurveyItem.Count = 1;
					basicNeedsSurveyItem.ItemId = clothingNeededGuid;
					dc.BasicNeedsSurveyItems.InsertOnSubmit(basicNeedsSurveyItem);
					dc.SubmitChanges();
				}
			}
			else
			{
				//Clothing not checked, if it's in the database remove it.
				if (basicNeedsSurveyClothing != null)
				{
					dc.BasicNeedsSurveyItems.DeleteOnSubmit(basicNeedsSurveyClothing);
					dc.SubmitChanges();
				}
			}


			//INSERT INTO THE BASICSURVEYITEMS TABLE
			//Text Boxes
			UpdateCountedItems(txtSheetRock.Attributes["guid"], txtSheetRock.Text, dc, surveyId);
			UpdateCountedItems(txtInsulation.Attributes["guid"], txtInsulation.Text, dc, surveyId);
			UpdateCountedItems(txtSingleBeds.Attributes["guid"], txtSingleBeds.Text, dc, surveyId);
			UpdateCountedItems(txtDoubleBeds.Attributes["guid"], txtDoubleBeds.Text, dc, surveyId);
			UpdateCountedItems(txtQueenBeds.Attributes["guid"], txtQueenBeds.Text, dc, surveyId);
			UpdateCountedItems(txtDressers.Attributes["guid"], txtDressers.Text, dc, surveyId);
			UpdateCountedItems(txtBedFrames.Attributes["guid"], txtBedFrames.Text, dc, surveyId);


			//Radio Button Lists
			//GET AND INSERT each of the radio items checked.
			UpdateRadioItems(rblGroupWaterHeater, dc, surveyId);
			UpdateRadioItems(rblDryer, dc, surveyId);
			UpdateRadioItems(rblStoveTop, dc, surveyId); 


			//Check Box Lists
			//GET AND INSERT each of the items checked.
			UpdateCheckedItems(cblAppliances, dc, surveyId);
			UpdateCheckedItems(cblFurniture, dc, surveyId);
			UpdateCheckedItems(cblLinen, dc, surveyId);
			UpdateCheckedItems(cblUtensils, dc, surveyId); 
			UpdateCheckedItems(cblWindowTreatments, dc, surveyId);

			lblNumber.Text = "Update Complete";

			divFormFields.Visible = false;
			divResults.Visible = true;

			var profile = (from p in dc.Profiles
							where p.UserId == userId
							select p).SingleOrDefault();

			lblTimeName.Text = "Updated by: " + profile.Firstname + " " + profile.Lastname + " on " + requestTime;

			hypGoToSurvey.NavigateUrl = "/Account/BasicNeedsSurveyView.aspx?surveyId=" + surveyId;
		}

		protected void UpdateCountedItems(string itemGuid, string itemCount, CrowdReliefDBDataContext dc, Guid basicNeedsSurveyId)
		{
			var query = (from b in dc.BasicNeedsSurveyItems
							where b.SurveyId == basicNeedsSurveyId &&
							b.ItemId == new Guid(itemGuid)
							select b).SingleOrDefault();
			
			//
			//
			//If no exists and they change to yes, we ALSO must remove the no which is not happening right now.
			//
			//

			int result;
			if (int.TryParse(itemCount, out result))
			{
				if(query != null)
				{
					//UPDATE
					query.Count = int.Parse(itemCount);
					dc.SubmitChanges();
				}
				else
				{
					//INSERT since it didn't exist before.
					Guid basicNeedsSurveyItemId = Guid.NewGuid();
					Guid itemId = new Guid(itemGuid);
					BasicNeedsSurveyItem basicNeedsSurveyItem = new BasicNeedsSurveyItem();
					basicNeedsSurveyItem.BasicSurveyItemId = basicNeedsSurveyItemId;
					basicNeedsSurveyItem.SurveyId = basicNeedsSurveyId;
					basicNeedsSurveyItem.Count = int.Parse(itemCount);
					basicNeedsSurveyItem.ItemId = itemId;
					dc.BasicNeedsSurveyItems.InsertOnSubmit(basicNeedsSurveyItem);
					dc.SubmitChanges();
				}
			}
			else
			{
				if (query != null)
				{
					//DELETE because there was no value.
					dc.BasicNeedsSurveyItems.DeleteOnSubmit(query);
					dc.SubmitChanges();
				}
			}
		}

		protected void UpdateRadioItems(RadioButtonList radioButtonList,  CrowdReliefDBDataContext dc, Guid basicNeedsSurveyId)
		{
			foreach(ListItem item in radioButtonList.Items)
			{
				if(!string.IsNullOrEmpty(item.Value))
				{ 
					var currentItem = (from bnsi in dc.BasicNeedsSurveyItems
									  where bnsi.SurveyId == basicNeedsSurveyId
									  && bnsi.ItemId == new Guid(item.Value)
									  && bnsi.ItemId != new Guid("17a48277-a38d-4350-9dd9-081a8687a974")
									  select bnsi).SingleOrDefault();

					if(currentItem != null)
					{
						//It's already in the database.
						if (item.Selected)
						{
							//Item selected is already in the database, so do nothing
						}
						else
						{
							//Item was not selected but it is in the database, so delete it
							dc.BasicNeedsSurveyItems.DeleteOnSubmit(currentItem);
							dc.SubmitChanges();
						}
					}
					else
					{
						//It's NOT in the database.
						if (item.Selected)
						{
							//Item was selected but not in the databse, so insert it
							BasicNeedsSurveyItem basicNeedsSurveyItem = new BasicNeedsSurveyItem();
							basicNeedsSurveyItem.BasicSurveyItemId = Guid.NewGuid();
							basicNeedsSurveyItem.Count = 1;
							basicNeedsSurveyItem.ItemId = new Guid(item.Value);
							basicNeedsSurveyItem.SurveyId = basicNeedsSurveyId;
							dc.BasicNeedsSurveyItems.InsertOnSubmit(basicNeedsSurveyItem);
							dc.SubmitChanges();
						}
						else
						{
							//Item was not selected and it's not in the database, so do nothing.
						}
					}
				}
			}
		}

		//Insert the checked items.
		protected void UpdateCheckedItems(CheckBoxList cbl, CrowdReliefDBDataContext dc, Guid basicNeedsSurveyId)
		{
			List<String> cblList = new List<string>();
			foreach (ListItem item in cbl.Items)
			{
				Guid itemId = new Guid(item.Value);
				//If item is not yet checked, then check it.
				var query = (from b in dc.BasicNeedsSurveyItems
								where b.SurveyId == basicNeedsSurveyId &&
								b.ItemId == itemId
								select b).SingleOrDefault();

				if (item.Selected)
				{
					if(query == null)
					{ 
						//Does not exist, check it.
						Guid basicNeedsSurveyItemId = Guid.NewGuid();
						BasicNeedsSurveyItem basicNeedsSurveyItem = new BasicNeedsSurveyItem();
						basicNeedsSurveyItem.BasicSurveyItemId = basicNeedsSurveyItemId;
						basicNeedsSurveyItem.SurveyId = basicNeedsSurveyId;
						basicNeedsSurveyItem.Count = 1;
						basicNeedsSurveyItem.ItemId = itemId;
						dc.BasicNeedsSurveyItems.InsertOnSubmit(basicNeedsSurveyItem);
						dc.SubmitChanges();
					}
				}
				else
				{
					//If item is not selected, then uncheck it.
					if (query != null)
					{
						dc.BasicNeedsSurveyItems.DeleteOnSubmit(query);
						dc.SubmitChanges();
					}
				}
			}
		}
	}
}
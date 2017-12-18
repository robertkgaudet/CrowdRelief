using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Xml.Linq;

namespace CrowdRelief
{ 
	public partial class Account_Organization_DisasterNeedsMap : System.Web.UI.Page
	{
		public string mapCoordinates = string.Empty;

		protected void Page_Load(object sender, EventArgs e)
		{
			//Page.Title = "Crowd Relief Disaster Needs Map - View a persons exact needs on an easy to use map.";
			//SetFacebookMetaTags("Facebook-Map.jpg", pageURL, "Crowd Relief Disaster Needs Map - View a persons exact needs on an easy to use map.");
			LoadClientLocationMap();
		}

		//get the lat/lon for an address and store it in the database.
		//Don't call the service once the lat and lon are figured out.
		//Show the persons house on a map on their dashboard.

		protected void LoadClientLocationMap()
		{
			string mapCoordinateOpen = "\r\n var clientLocations = [";
			string mapCoordinateClose = "]; \r\n";
			string mapComma = ",";
			int count = 0;

			CrowdReliefDBDataContext dc = new CrowdReliefDBDataContext();

			var clientLocations = from c in dc.BasicNeedsSurveys
								  where c.Hidden == false
								  select new { IsRebuild = false, RebuildId = new Guid(), c.SurveyId, c.SurveyNumber, c.FirstName, c.LastName, c.HomeLossAddress, c.HomeLossCity, c.HomeLossState, c.HomeLossZipCode, c.Latitude, c.Longitude };

			var rebuildLocations = from r in dc.Rebuilds
								   join a in dc.Addresses on r.RebuildAddressId equals a.AddressId
								   join p in dc.Profiles on r.SurvivorId equals p.UserId
								   select new { IsRebuild = true, r.RebuildId, SurveyId = new Guid(), SurveyNumber = 0, FirstName = p.Firstname, LastName = p.Lastname, HomeLossAddress = a.Address1, HomeLossCity = a.City, HomeLossState = a.State, HomeLossZipCode = a.Zip, a.Latitude, a.Longitude };

			//Get the rebuild locations... and union to the client Locations.

			var mapLocations = clientLocations.Union(rebuildLocations);
			
			int locationCount = mapLocations.Count();

			foreach (var location in mapLocations)
			{
				count = count + 1;
				//-Call the web service to get the lat/long.
				//-Make a db call and get all of the items they need.
				//-Get the latest status and change out icons based on it.
				//-If they have a campaign then show it.
				string latitude = location.Latitude;
				string longitude = location.Longitude;
				string message = string.Empty;
				string surveyType = "survey";

				string currentStatus = string.Empty;

				if (location.IsRebuild)
				{
					currentStatus = "<a href=\"/Account/Organization/Rebuild.aspx?rebuildId=" + location.RebuildId + "\">View Rebuild</a><br><br>";
				}
				else
				{
					currentStatus = "<a href=\"/Account/BasicNeedsSurveyView.aspx?surveyId=" + location.SurveyId + "\">View Survey</a><br><br>";
				}

				string extraItemCount = string.Empty;
				int itemCount = Tools.GetSurveyItemCount(location.SurveyId);
				if (itemCount > 10)
				{
					extraItemCount = " plus " + (itemCount - 10) + " more items.";
				}
				string neededItemCount = itemCount + " household items. ";
				string needsText = "<h3>" + location.FirstName + "</h3>";
				string donateToPerson = string.Empty;
				string neededItemsList = string.Empty;

				if (String.IsNullOrEmpty(longitude) && String.IsNullOrEmpty(latitude))
				{
					string address = location.HomeLossAddress + " " + location.HomeLossCity + ", " + location.HomeLossState;
					if (GetLatitudeLongitude(address, out latitude, out longitude, out message))
					{
						if (!String.IsNullOrEmpty(latitude) && !String.IsNullOrEmpty(longitude))
						{
							//mapCoordinates += "['" + location.FirstName.Replace("'","").Replace(",","") + "', " + latitude + ", " + longitude + ", " + count + "]";
							var clientLocation = (from c in dc.BasicNeedsSurveys
												  where c.SurveyId == location.SurveyId
												  && c.Hidden == false
												  select c).SingleOrDefault();

							clientLocation.Latitude = latitude;
							clientLocation.Longitude = longitude;
							dc.SubmitChanges();
						}
					}
					else
					{
						//Error getting lat and lon...
						//Invalide address perhaps?
						//Store this information in a log file.
					}
				}

				if (locationCount == count)
				{
					//Last record dont need.
					mapComma = string.Empty;
				}

				if (!String.IsNullOrEmpty(latitude) && !String.IsNullOrEmpty(longitude))
				{

					var neededItems = (from i in dc.Items
									   join bnsi in dc.BasicNeedsSurveyItems on i.ItemId equals bnsi.ItemId
									   select new { i.Name }).Take(10).Distinct();

					var query = neededItems.ToList();

					foreach (var item in query)
					{
						neededItemsList = neededItemsList + item.Name.Replace("'", "") + ", ";
					}

					neededItemsList = "<small>" + neededItemsList.ToString() + extraItemCount + "</small>";
					
					var surveyTypeResult = (from bns in dc.BasicNeedsStatus
											join bncn in dc.BasicNeedsCaseNotes on bns.BasicNeedsStatusId equals bncn.BasicNeedsStatusId
											where bncn.SurveyId == location.SurveyId
											orderby bncn.CreatedOn descending
											select new { bns.Name }).Take(1).SingleOrDefault();

					if (surveyTypeResult != null)
					{
						//On Hold
						//Pending Closure
						//Vetting Required
						//Closed
						//Open - Active Case Management
						if (!string.IsNullOrEmpty(surveyTypeResult.Name.Trim()))
						{
							currentStatus = surveyTypeResult.Name;
						}
						string surveyStatus = surveyTypeResult.Name;

						var campaign = (from c in dc.BasicNeedsCampaigns
										where c.BasicNeedsSurveyId == location.SurveyId
										&& c.Hidden != true
										select c).SingleOrDefault();

						if (campaign != null)
						{
							donateToPerson = "<p><a href=\"/Account/BasicNeedsSurveyView.aspx?surveyId=" + location.SurveyId + "\">View Survey</a></p><br>";
							surveyStatus = "Donate";
						}

						var caseWorkers = (from cw in dc.SurveyCaseWorkers
										   join p in dc.Profiles on cw.UserId equals p.UserId
										   where cw.SurveyId == location.SurveyId
										   select new { p.Firstname, p.Lastname }).SingleOrDefault();

						string caseManagerName = "Not yet assigned";
						if (caseWorkers != null)
						{
							if (caseWorkers.Firstname != null && caseWorkers.Lastname != null)
							{
								caseManagerName = caseWorkers.Firstname + " " + caseWorkers.Lastname;
							}
						}

						switch (surveyStatus)
						{
							case "Closed":
								{
									surveyType = "complete";
									currentStatus = "<strong>Whooo hooo!</strong></br>This client is complete thanks to case worker <strong>" + caseManagerName + "</strong>";
									neededItemCount = string.Empty;
									needsText = string.Empty;
									neededItemsList = string.Empty;
								}
								break;
							case "Open - Active Case Management":
								{
									surveyType = "casemanagment";
									currentStatus = "</br></br>The case manager is <strong>" + caseManagerName + "</strong><h4>2 volunteers are needed</h4>A photographer is needed to take the clients photos.<br>A writer is needed to document clients experience.<br>Volunteer by going here <a href=\"/Register.aspx?interactionType=Volunteer\">Volunteer Now</a> or email us at <a href=\"mailto:support@crowdrelief.net\">support@crowdrelief.net</a> to volunteer, reference the survey number below in your email.";

								}
								break;
							case "Donate":
								{
									surveyType = "donate";
									currentStatus = "<br>Vetted by case worker <strong>" + caseManagerName + "</strong>";
								}
								break;
							case "Vetting Required":
								{
									surveyType = "survey";
									currentStatus = "<h3>2 volunteers needed</h3>A photographer is needed to take the clients photos.<br>A writer is needed to document clients experience.";
								}
								break;
							case "On Hold":
								{
									surveyType = "followup";
									currentStatus = "Client on hold";
								}
								break;
							case "Pending Closure":
								{
									surveyType = "complete";
									currentStatus = "Ready to be closed";
								}
								break;
							case "Photos Needed":
								{
									surveyType = "photos";
									currentStatus = "Photographer needed to take clients photos, contact case worker <strong>" + caseManagerName + "</strong>";
								}
								break;
							case "Story Needed":
								{
									surveyType = "story";
									currentStatus = "Writer needed to document clients experience, contact case worker <strong>" + caseManagerName + "</strong>";
								}
								break;
						}
					}

					string blur = Request.QueryString["blur"];
					blur = "no";
					if (String.IsNullOrEmpty(blur))
					{
						latitude = latitude + " + ((Math.random() > 0.5 ? 0.001 : -0.009) + Math.random() * 0.008)";
					}
					string needs = needsText + currentStatus + donateToPerson + neededItemCount + neededItemsList;
					string infoWindowContents = "<div>" + needs + "</br></br><small>Survey number " + location.SurveyNumber + "</small></div>";

					mapCoordinates += "{position: new google.maps.LatLng(" + latitude + ", " + longitude + "), type: '" + surveyType + "', title: '" + infoWindowContents + "'}" + mapComma + "\r\n";
				}
			}

			mapCoordinates = mapCoordinateOpen + mapCoordinates + mapCoordinateClose;
		}

		protected bool GetLatitudeLongitude(string address, out string latitude, out string longitude, out string message)
		{
			message = string.Empty;
			latitude = string.Empty;
			longitude = string.Empty;
			bool status = true;
			try
			{
				status = true;
				//var address = "123 something st, somewhere";
				var requestUri = string.Format("http://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false", Uri.EscapeDataString(address));

				var request = WebRequest.Create(requestUri);
				var response = request.GetResponse();
				var xdoc = XDocument.Load(response.GetResponseStream());

				var result = xdoc.Element("GeocodeResponse").Element("result");
				var locationElement = result.Element("geometry").Element("location");

				latitude = locationElement.Element("lat").Value;
				longitude = locationElement.Element("lng").Value;
				message = "success";
			}
			catch (Exception ex)
			{
				status = false;
				message = ex.Message;
			}
			return status;//return false if failed.
		}
	}
}
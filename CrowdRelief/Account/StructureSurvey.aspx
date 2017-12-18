<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StructureSurvey.aspx.cs" Inherits="CrowdRelief.Account_StructureSurvey" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

	
				<div class="container structureSurvey-1" id="divPostANeed" runat="server">
					<div class="row">
						<div class="col-xs-1 col-sm-2"></div>
						<div class="col-xs-10 col-sm-8"> 
							<div  class="form-horizontal">
							<fieldset>
								
								<!-- Multiple Checkboxes (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="checkboxes">HVAC (Heaing/Air Conditioning)</label>
							  <div class="col-md-4">

								  <asp:CheckBoxList CssClass="radio-inline" ID="cblHVAC" runat="server" RepeatLayout="Table" RepeatColumns="1" Font-Bold="false">
									  <asp:ListItem Text="Central Air" Value="Central Air"></asp:ListItem>
									  <asp:ListItem Text="Window Unit" Value="Window Unit"></asp:ListItem>
								  </asp:CheckBoxList>
							  </div>
							</div>

							<!-- Multiple Checkboxes -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="checkboxGroupKitchen">Cabinets, Counters, Baths Needed</label>
							  <div class="col-md-4">
								  
								  <asp:CheckBoxList CssClass="radio-inline" ID="cblCabinetsCountersBaths" runat="server" RepeatLayout="Table" RepeatColumns="1" Font-Bold="false">
									  <asp:ListItem Text="Cabinets" Value="Cabinets"></asp:ListItem>
									  <asp:ListItem Text="Counter Tops" Value="Counter Tops"></asp:ListItem>
									  <asp:ListItem Text="Sinks" Value="Sinks"></asp:ListItem>
									  <asp:ListItem Text="Faucets" Value="Faucets"></asp:ListItem>
									  <asp:ListItem Text="Toilet" Value="Toilet"></asp:ListItem>
									  <asp:ListItem Text="Bath" Value="Bath"></asp:ListItem>
									  <asp:ListItem Text="Shower" Value="Shower"></asp:ListItem>
								  </asp:CheckBoxList>

							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtWindowCount">Number of Windows</label>  
							  <div class="col-md-2">
							  <asp:TextBox id="txtWindowCount" name="txtWindowCount" runat="server" type="text" placeholder="" maxlength="2" class="form-control input-md"></asp:TextBox>
    
							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtNumberOfDoors">Number of Doors</label>  
							  <div class="col-md-2">
							  <asp:TextBox id="txtNumberOfDoors" name="txtNumberOfDoors" runat="server" type="text" placeholder="" maxlength="2" class="form-control input-md"></asp:TextBox>
    
							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtMoneyReceived">Total Money Received?</label>  
							  <div class="col-md-4">
							  <asp:TextBox id="txtMoneyReceived" name="txtMoneyReceived" runat="server" type="text" placeholder="" class="form-control input-md" required=""></asp:TextBox>
    
							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtTotalMoneyLeft">Total Money Remaining?</label>  
							  <div class="col-md-4">
							  <asp:TextBox id="txtTotalMoneyLeft" name="txtTotalMoneyLeft" runat="server" type="text" placeholder="" class="form-control input-md" required=""></asp:TextBox>
    
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupElectrical">Is Electrical Work Needed?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupElectrical-0">
								  <input type="radio" name="radioGroupElectrical" id="radioGroupElectrical-0" value="1" checked="checked">
								  Yes
								</label> 
								<label class="radio-inline" for="radioGroupElectrical-1">
								  <input type="radio" name="radioGroupElectrical" id="radioGroupElectrical-1" value="2">
								  No
								</label>
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupPlumbing">Is Plumbing Work Needed?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupPlumbing-0">
								  <input type="radio" name="radioGroupPlumbing" id="radioGroupPlumbing-0" value="1" checked="checked">
								  Yes
								</label> 
								<label class="radio-inline" for="radioGroupPlumbing-1">
								  <input type="radio" name="radioGroupPlumbing" id="radioGroupPlumbing-1" value="2">
								  No
								</label>
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupFoundation">Is Foundation Work Needed?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupFoundation-0">
								  <input type="radio" name="radioGroupFoundation" id="radioGroupFoundation-0" value="1" checked="checked">
								  Yes
								</label> 
								<label class="radio-inline" for="radioGroupFoundation-1">
								  <input type="radio" name="radioGroupFoundation" id="radioGroupFoundation-1" value="2">
								  No
								</label>
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupRoof">Was there roof damage?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupRoof-0">
								  <input type="radio" name="radioGroupRoof" id="radioGroupRoof-0" value="1" checked="checked">
								  None
								</label> 
								<label class="radio-inline" for="radioGroupRoof-1">
								  <input type="radio" name="radioGroupRoof" id="radioGroupRoof-1" value="2">
								  Minor
								</label> 
								<label class="radio-inline" for="radioGroupRoof-2">
								  <input type="radio" name="radioGroupRoof" id="radioGroupRoof-2" value="3">
								  Major
								</label>
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupCeiling">Is Ceiling Work Needed?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupCeiling-0">
								  <input type="radio" name="radioGroupCeiling" id="radioGroupCeiling-0" value="1" checked="checked">
								  Yes
								</label> 
								<label class="radio-inline" for="radioGroupCeiling-1">
								  <input type="radio" name="radioGroupCeiling" id="radioGroupCeiling-1" value="2">
								  No
								</label>
							  </div>
							</div>

							<!-- Multiple Radios (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="radioGroupChimney">Do you have fireplaces?</label>
							  <div class="col-md-4"> 
								<label class="radio-inline" for="radioGroupChimney-0">
								  <input type="radio" name="radioGroupChimney" id="radioGroupChimney-0" value="1" checked="checked">
								  Yes
								</label> 
								<label class="radio-inline" for="radioGroupChimney-1">
								  <input type="radio" name="radioGroupChimney" id="radioGroupChimney-1" value="2">
								  No
								</label>
							  </div>
							</div>

							<!-- Multiple Checkboxes (inline) -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="chkBoxGroupFlooring">Flooring Needed?</label>
							  <div class="col-md-4">
								<label class="checkbox-inline" for="chkBoxGroupFlooring-0">
								  <input type="checkbox" name="chkBoxGroupFlooring" id="chkBoxGroupFlooring-0" value="1">
								  None
								</label>
								<label class="checkbox-inline" for="chkBoxGroupFlooring-1">
								  <input type="checkbox" name="chkBoxGroupFlooring" id="chkBoxGroupFlooring-1" value="2">
								  Hardwood
								</label>
								<label class="checkbox-inline" for="chkBoxGroupFlooring-2">
								  <input type="checkbox" name="chkBoxGroupFlooring" id="chkBoxGroupFlooring-2" value="3">
								  Carpet
								</label>
								<label class="checkbox-inline" for="chkBoxGroupFlooring-3">
								  <input type="checkbox" name="chkBoxGroupFlooring" id="chkBoxGroupFlooring-3" value="4">
								  Tile
								</label>
								<label class="checkbox-inline" for="chkBoxGroupFlooring-4">
								  <input type="checkbox" name="chkBoxGroupFlooring" id="chkBoxGroupFlooring-4" value="">
								  Other
								</label>
							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtSquareFeet">How many square feet is your home?</label>  
							  <div class="col-md-2">
							  <input id="txtSquareFeet" name="txtSquareFeet" type="text" placeholder="Square Feet" class="form-control input-md">
    
							  </div>
							</div>

							<!-- Text input-->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="txtOutBuildingSquareFeet">Outbuilding Square Feet</label>  
							  <div class="col-md-2">
							  <input id="txtOutBuildingSquareFeet" name="txtOutBuildingSquareFeet" type="text" placeholder="Square Feet" class="form-control input-md">
							  <span class="help-block">If you have outside buildings, enter their square footage.</span>  
							  </div>
							</div>

							<!-- Button -->
							<div class="form-group">
							  <label class="col-md-4 control-label" for="btnSubmit"></label>
							  <div class="col-md-4">
								<button id="btnSubmit" name="btnSubmit" class="btn btn-primary">Send Help Request</button>
							  </div>
							</div>

							</fieldset>
							</div>
						</div>
						<div class="col-xs-1 col-sm-2"></div>
					</div>
				</div>

</asp:Content>


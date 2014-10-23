<%@ Page Title="Parent-Child DropDownLists In ASP.NET WebForms: Example 2, Using Code Behind and CompareValidator Controls" Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Example2.aspx.vb" Inherits="demos_parent_child_dropdown_Example2" %>

<asp:Content ID="cntSide" ContentPlaceHolderID="cphSidebar" Runat="Server">
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphMain" Runat="Server">
    <h2>
        Parent-Child DropDownList Controls<br />
        In ASP.NET Web Forms
    </h2>
    <h3>
        Example 2: Using Code Behind And CompareValidator Controls
    </h3>

    <p class="note">
        This demo uses code behind to bind data to the parent and child DropDownLists, as well as the detail GridView. 
        It also uses CompareValidators to ensure a valid option is chosen from the DropDownMenus before they are bound.
    </p>

    <asp:Label runat="server" ID="lblParent" Text="Select A State: " />
    <asp:DropDownList runat="server" ID="ddlParent" AutoPostBack="true">
        <asp:ListItem Text="Select A State ..." Value="0" />
    </asp:DropDownList>
    <asp:CompareValidator runat="server" ID="cvParent" ControlToValidate="ddlParent" ValueToCompare="0" Operator="NotEqual" ErrorMessage="Please select a valid option" Display="Dynamic" />
    <br />
    <asp:Label runat="server" ID="lblChild" Text="Select A Town: " />
    <asp:DropDownList runat="server" ID="ddlChild" AutoPostBack="true">
        <asp:ListItem Text="Select A State First" Value="0" />
    </asp:DropDownList>
    <asp:CompareValidator runat="server" ID="cvChild" ControlToValidate="ddlChild" ValueToCompare="0" Operator="NotEqual" ErrorMessage="Please select a valid option" Display="Dynamic" />
    <br />
    <br />
    <asp:GridView runat="server" ID="gvDetails" CellPadding="5" AutoGenerateColumns="false">
        <AlternatingRowStyle BackColor="LightGray" />
        <HeaderStyle BackColor="LightYellow" Font-Bold="True" HorizontalAlign="Center" />
        <Columns>
            <asp:BoundField HeaderText="City" DataField="city_name" />
            <asp:BoundField HeaderText="State" DataField="state_code" />
            <asp:BoundField HeaderText="ZIP Code" DataField="zip_code" />
            <asp:BoundField HeaderText="Latitide" DataField="latitude" />
            <asp:BoundField HeaderText="Longitude" DataField="longitude" />
        </Columns>
    </asp:GridView>
</asp:Content>

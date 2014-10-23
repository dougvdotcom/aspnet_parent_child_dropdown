<%@ Page Title="Parent-Child DropDownLists In ASP.NET WebForms: Example 1B: Augmenting The SqlDataSource Control Methodology" Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Example1B.aspx.vb" Inherits="demos_parent_child_dropdown_Example1B" %>

<asp:Content ID="cntSidebar" ContentPlaceHolderID="cphSidebar" Runat="Server">
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphMain" Runat="Server">
    <h2>
        Parent-Child DropDownList Controls<br />
        In ASP.NET Web Forms
    </h2>
    <h3>
        Example 1B: Augmenting The SqlDataSource Control Methodology
    </h3>

    <p class="note">
        This demo uses a small bit of code behind to augment the SqlDataSource approach to parent-child DropDownLists. 
        Specifically, the code behind will, every time the parent DropDownList has its selected index changed, rebind the child DropDownList, select its first item, and rebind the SqlDataSource that populates the GridView.
    </p>

    <asp:Label runat="server" ID="lblParent" Text="Select A State: " />
    <!-- parent ddl -->
    <asp:DropDownList runat="server" ID="ddlParent" DataSourceID="sqlParentDDL" DataValueField="state_postal_code" DataTextField="state_short_name" AutoPostBack="true" />
    <!-- parent ddl is populated with a parameterless SQL query -->
    <asp:SqlDataSource runat="server" ID="sqlParentDDL" SelectCommand="get_all_states" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:some_connection_string %>" />
    <br />
    <!-- child ddl -->
    <asp:Label runat="server" ID="lblChild" Text="Select A Town: " />
    <asp:DropDownList runat="server" ID="ddlChild" DataSourceID="sqlChildDDL" DataValueField="zip_code" DataTextField="city_name" AutoPostBack="true" />
    <!-- child ddl gets its parameter value from the selected value of the parent ddl -->
    <!-- 
        ControlID: Name of the ASP.NET control that is providing the paramter's value
        Name: The name of the parameter in your stored procedure / SQL query
        PropertyName: The property of the control, specified in ControlID, that will supply the value to your query, specified in Name
    -->
    <asp:SqlDataSource runat="server" ID="sqlChildDDL" SelectCommand="get_by_zip_code" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:some_connection_string %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlParent" Name="state_code" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />

    <!-- A GridView to show the resuls -->
    <asp:GridView runat="server" ID="gvDetails" DataSourceID="sqlZipDetails" CellPadding="5" AutoGenerateColumns="false">
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
    <!-- the GridView gets records based on the SelectedValue of ddlChild -->
    <asp:SqlDataSource runat="server" ID="sqlZipDetails" SelectCommand="get_zip_code" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:some_connection_string %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlChild" Name="zip_code" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

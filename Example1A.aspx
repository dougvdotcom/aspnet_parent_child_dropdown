<%@ Page Title="Parent-Child DropDownLists In ASP.NET WebForms: Example 1A, Parent / Child DropDownLists lone" Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Example1A.aspx.vb" Inherits="demos_parent_child_dropdown_Example1A" %>

<asp:Content ID="cntSidebar" ContentPlaceHolderID="cphSidebar" Runat="Server">
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphMain" Runat="Server">
    <h2>
        Parent-Child DropDownList Controls<br />
        In ASP.NET Web Forms
    </h2>
    <h3>
        Example 1A: Parent / Child DropDownLists Alone
    </h3>

    <p class="note">
        This demo shows a simple parent / child DropDownList driven by SqlDataSource controls.
    </p>

    <asp:Label runat="server" ID="lblParent" Text="Select A State: " />
    <!-- parent ddl -->
    <asp:DropDownList runat="server" ID="ddlParent" DataSourceID="sqlParentDDL" DataValueField="state_postal_code" DataTextField="state_short_name" AutoPostBack="true" />
    <!-- parent ddl is populated with a parameterless SQL query -->
    <asp:SqlDataSource runat="server" ID="sqlParentDDL" SelectCommand="get_states" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:some_connection_string %>" />
    <br />
    <!-- child ddl -->
    <asp:Label runat="server" ID="lblChild" Text="Select A Town: " />
    <asp:DropDownList runat="server" ID="ddlChild" DataSourceID="sqlChildDDL" DataValueField="zip_code" DataTextField="city_name" />
    <!-- child ddl gets its parameter value from the selected value of the parent ddl -->
    <!-- 
        ControlParamter property values
        ControlID: The ASP.NET control that is providing the paramter's value
        Name: The parameter's name as it appears in your stored procedure / SQL query
        PropertyName: The property of the ASP.NET control that will supply the value to your parameter
    -->
    <asp:SqlDataSource runat="server" ID="sqlChildDDL" SelectCommand="get_by_state_code" SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:some_connection_string %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlParent" Name="state_code" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>


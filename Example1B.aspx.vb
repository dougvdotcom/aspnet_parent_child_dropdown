Partial Class demos_parent_child_dropdown_Example1B
    Inherits System.Web.UI.Page

    Sub ddlParent_selectedIndexChanged(Sender As Object, E As EventArgs) Handles ddlParent.SelectedIndexChanged
        ddlChild.DataBind()
        ddlChild.SelectedIndex = 0
        sqlZipDetails.DataBind()
    End Sub

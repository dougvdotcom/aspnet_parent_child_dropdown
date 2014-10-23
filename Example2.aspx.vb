Partial Class demos_parent_child_dropdown_Example2
    Inherits System.Web.UI.Page

    Sub Page_Load(Sender As Object, E As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ddlParent_dataBind()
        End If
    End Sub

    Sub ddlParent_dataBind()
        Dim objConn As New SqlConnection(ConfigurationManager.ConnectionStrings("some_connection_string").ConnectionString)
        Dim objCmd As New SqlCommand("_get_all_states", objConn)
        objCmd.CommandType = CommandType.StoredProcedure

        Dim objReader As SqlDataReader

        objConn.Open()
        objReader = objCmd.ExecuteReader()

        If Not objReader.HasRows Then
            ddlParent.Items.Clear()
            ddlParent.Items.Add("No records found.")
            ddlParent.Enabled = False
        Else
            ddlChild.Enabled = True
            ddlParent.DataSource = objReader
            ddlParent.DataTextField = "state_short_name"
            ddlParent.DataValueField = "state_postal_code"
            ddlParent.DataBind()
            ddlParent.Items.Insert(0, New ListItem("Select A State ...", "0"))
        End If

        objConn.Close()
        objCmd.Dispose()
        objConn.Dispose()
    End Sub

    Sub ddlChild_dataBind(strKey As String)
        ddlChild.Items.Clear()

        Dim objConn As New SqlConnection(ConfigurationManager.ConnectionStrings("some_connection_string").ConnectionString)
        Dim objCmd As New SqlCommand("zip_codes_by_state_code", objConn)
        objCmd.CommandType = CommandType.StoredProcedure

        objCmd.Parameters.Add(New SqlParameter("state_code", SqlDbType.Char, 2))
        objCmd.Parameters("state_code").Value = strKey

        Dim objReader As SqlDataReader

        objConn.Open()
        objReader = objCmd.ExecuteReader()

        If Not objReader.HasRows Then
            ddlChild.Items.Clear()
            ddlChild.Items.Insert(0, "Error getting towns list from database")
        Else
            ddlChild.Enabled = True
            ddlChild.DataSource = objReader
            ddlChild.DataTextField = "city_name"
            ddlChild.DataValueField = "zip_code"
            ddlChild.DataBind()
            ddlChild.Items.Insert(0, New ListItem("Select A Town ...", "0"))
        End If

        objConn.Close()
        objCmd.Dispose()
        objConn.Dispose()
    End Sub

    Sub gvDetails_dataBind(strKey As String)
        Dim objConn As New SqlConnection(ConfigurationManager.ConnectionStrings("some_connection_string").ConnectionString)
        Dim objCmd As New SqlCommand("get_by_zip_code", objConn)
        objCmd.CommandType = CommandType.StoredProcedure

        objCmd.Parameters.Add(New SqlParameter("zip_code", SqlDbType.Char, 5))
        objCmd.Parameters("zip_code").Value = strKey

        Dim objReader As SqlDataReader

        objConn.Open()
        objReader = objCmd.ExecuteReader()

        gvDetails.DataSource = objReader
        gvDetails.DataBind()

        objConn.Close()
        objCmd.Dispose()
        objConn.Dispose()
    End Sub

    Sub ddlParent_selectedIndexChanged(Sender As Object, E As EventArgs) Handles ddlParent.SelectedIndexChanged
        cvParent.Validate()
        If cvParent.IsValid Then
            ddlChild_dataBind(ddlParent.SelectedValue)
            ddlChild.SelectedIndex = 0
        End If
        gvDetails_reset()
    End Sub

    Sub ddlChild_selectedIndexChanged(Sender As Object, E As EventArgs) Handles ddlChild.SelectedIndexChanged
        cvChild.Validate()
        If cvChild.IsValid Then
            gvDetails_dataBind(ddlChild.SelectedValue)
        Else
            gvDetails_reset()
        End If
    End Sub

    Sub gvDetails_reset()
        gvDetails.DataSource = Nothing
        gvDetails.DataBind()
    End Sub

End Class

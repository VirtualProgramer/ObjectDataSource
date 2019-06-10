<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e) {
        Response.Redirect("~/MemberList.aspx");
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <h1 class="addForm" >Edit Page</h1>
        <asp:FormView class="addForm flexRowBetween" OnItemUpdated="FormView1_ItemUpdated" CssClass="memEditFormView flexColumnStart" ID="FormView1" runat="server" DataKeyNames="Id" DataSourceID="ObjectDataSource1" DefaultMode="Edit">
            <EditItemTemplate>
                Id:
            <asp:Label class="subRow" Text='<%# Eval("id") %>' runat="server" ID="IdLabel1" /><br />
                UserName:
            <asp:TextBox class="subRow" Text='<%# Bind("account") %>' runat="server" ID="UserNameTextBox" /><br />
                Password:
            <asp:TextBox class="subRow" Text='<%# Bind("password") %>' runat="server" ID="PasswordTextBox" /><br />
                <asp:LinkButton class="addButton" runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" />&nbsp;
                <asp:LinkButton class="addButton" runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" PostBackUrl="~/MemberList.aspx" />
            </EditItemTemplate>
            <InsertItemTemplate>
                UserName:
            <asp:TextBox Text='<%# Bind("account") %>' runat="server" ID="UserNameTextBox" /><br />
                Password:
            <asp:TextBox Text='<%# Bind("password") %>' runat="server" ID="PasswordTextBox" /><br />
                <asp:LinkButton runat="server" Text="Insert" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
            </InsertItemTemplate>
            <ItemTemplate>
                Id:
            <asp:Label Text='<%# Eval("id") %>' runat="server" ID="IdLabel" /><br />
                UserName:
            <asp:Label Text='<%# Bind("account") %>' runat="server" ID="UserNameLabel" /><br />
                Password:
            <asp:Label Text='<%# Bind("password") %>' runat="server" ID="PasswordLabel" /><br />
                <asp:LinkButton runat="server" Text="Edit" CommandName="Edit" ID="EditButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="Delete" CommandName="Delete" ID="DeleteButton" CausesValidation="False" />&nbsp;<asp:LinkButton runat="server" Text="New" CommandName="New" ID="NewButton" CausesValidation="False" />
            </ItemTemplate>
        </asp:FormView>

        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" DataObjectTypeName="Member" SelectMethod="GetMember" TypeName="MemberUtility" UpdateMethod="UpdateMember">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="id" Name="id" Type="Int32"></asp:QueryStringParameter>

            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:MyDBConnectionString1 %>' DeleteCommand="DELETE FROM [Members] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Members] ([UserName], [Password]) VALUES (@UserName, @Password)" SelectCommand="SELECT * FROM [Members] WHERE ([Id] = @Id)" UpdateCommand="UPDATE [Members] SET [UserName] = @UserName, [Password] = @Password WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Password" Type="String"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="id" Name="Id" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Password" Type="String"></asp:Parameter>
                <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e) {
        Response.Redirect("~/ProductList.aspx");
    }

    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e) {
        FileUpload fu = FormView1.FindControl("FileUpload1") as FileUpload;

        string fileName = DateTime.Now.ToString("yyMMdd_HHmmss_ffff") + ".jpg";

        e.NewValues["img"] = fileName;

        fu.SaveAs(Server.MapPath("img/" + fileName));
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="addForm">

        <h1>Product Edit</h1>
        <asp:FormView ID="FormView1" runat="server" DataSourceID="ObjectDataSource1" DefaultMode="Edit" DataKeyNames="ID" OnItemUpdating="FormView1_ItemUpdating">
            <EditItemTemplate>
                id:
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("id") %>'></asp:Label><br />
                name:
                <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="nameTextBox" /><br />
                price:
                <asp:TextBox Text='<%# Bind("Price") %>' runat="server" ID="priceTextBox" /><br />
                count:
                <asp:TextBox Text='<%# Bind("Amount") %>' runat="server" ID="countTextBox" /><br />
                img:
                <asp:FileUpload ID="FileUpload1" runat="server" FileBytes='<%# Bind("img") %>' />
                <label id="FileUploadLabel"></label>
                <br />
                <asp:LinkButton runat="server" Text="Update" CommandName="Update" ID="UpdateButton" CausesValidation="True" PostBackUrl="~/ProductList.aspx" />
                &nbsp;
                <asp:LinkButton runat="server" Text="Cancel" CommandName="Cancel" ID="UpdateCancelButton" CausesValidation="False" />
            </EditItemTemplate>
            <InsertItemTemplate>
                id:
                <asp:TextBox Text='<%# Bind("Id") %>' runat="server" ID="idTextBox" /><br />
                name:
                <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="nameTextBox" /><br />
                price:
                <asp:TextBox Text='<%# Bind("Price") %>' runat="server" ID="priceTextBox" /><br />
                count:
                <asp:TextBox Text='<%# Bind("Amount") %>' runat="server" ID="countTextBox" /><br />
                img:
                <asp:TextBox Text='<%# Bind("ImageFileName") %>' runat="server" ID="imgTextBox" /><br />
                <asp:LinkButton runat="server" Text="插入" CommandName="Insert" ID="InsertButton" CausesValidation="True" />&nbsp;<asp:LinkButton runat="server" Text="取消" CommandName="Cancel" ID="InsertCancelButton" CausesValidation="False" />
            </InsertItemTemplate>
            <ItemTemplate>
                id:
                <asp:Label Text='<%# Bind("id") %>' runat="server" ID="idLabel" /><br />
                name:
                <asp:Label Text='<%# Bind("name") %>' runat="server" ID="nameLabel" /><br />
                price:
                <asp:Label Text='<%# Bind("price") %>' runat="server" ID="priceLabel" /><br />
                count:
                <asp:Label Text='<%# Bind("Amount") %>' runat="server" ID="countLabel" /><br />
                img:
                <asp:Label Text='<%# Bind("ImageFileName") %>' runat="server" ID="imgLabel" /><br />
                <asp:LinkButton runat="server" Text="編輯" CommandName="Edit" ID="EditButton" CausesValidation="False" />
            </ItemTemplate>
        </asp:FormView>

        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" SelectMethod="GetProduct" TypeName="ProdUtility" UpdateMethod="UpdateProduct" DataObjectTypeName="Prod">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="id" Name="id" Type="Int32"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:ObjectDataSource>

    </div>
</asp:Content>


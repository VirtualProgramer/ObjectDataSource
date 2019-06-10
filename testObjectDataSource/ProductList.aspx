<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    private void pdListGridView() {

    }

    public static string GetFileName(object obj) {
        if (obj.ToString() == "") {
            return "/img/default.png";
        } else {
            return $"/img/{obj}";
        }
    }

    protected void Page_Load(object sender, EventArgs e) {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="prodListForm">
        <h1 class="addForm">Product List</h1>
        <div class="addForm">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSource1">
                <HeaderTemplate>
                    <table class="w3-table-all w3-card-4">
                        <tr>
                            <th>產品名稱</th>
                            <th>價格</th>
                            <th>數量</th>
                            <th>圖片</th>
                            <th>功能</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("name") %></td>
                        <td><%# Eval("price") %></td>
                        <td><%# Eval("count") %></td>
                        <td>
                            <div class="prodImg" style="background-image:url('..<%# GetFileName(Eval("img")) %>');"></div>
                        </td>
                        <td>
                            <asp:HyperLink ID="HyperLink1" runat="server"
                                NavigateUrl='<%# Eval("ID" , "~/ProductEdit.aspx?id={0}") %>'>編輯</asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" SelectMethod="GetAllProd" TypeName="ProdUtility"></asp:ObjectDataSource>

        </div>
    </div>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    private void pdListGridView() {

        ProdUtility pu = new ProdUtility();
        List<Product> pdList = pu.GetAllProd();
        GridView1.DataSource = pdList;
        GridView1.DataBind();
    }

    public static string GetFileName(object obj) {
        if (obj == null) {
            return "style=\"background-image:url('../img/default.png')\"";
        } else {
            return $"style=\"background-image:url('../img/{obj}')\"";
        }
    }

    protected void Button1_Click(object sender, EventArgs e) {

    }

    protected void Page_Load(object sender, EventArgs e) {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="flexColumnStart">
        <div class="cover flexRowStart">
            <div class="coverImg"></div>
            <div class="coverInfo flexColumnBetween">
                <h3>Tom Clancy's Rainbow Six® Siege</h3>
                <br/><h4>Purchase Now</h4>
            </div>
        </div>

        <div class="w3-container w3-text-grey" id="jeans">
            <p>8 items</p>
        </div>

        <asp:GridView ID="GridView1" class="gridView" runat="server"></asp:GridView>

        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSource1">
            <HeaderTemplate>
                <div class="prodListForm">
            </HeaderTemplate>
            <ItemTemplate>

                <div class="w3-container prodItem">
                    <%--<div class="prodItemNoImg"></div>--%>
                    <%--<div class="prodItemImg" style=<%# GetFileName(Eval("img")) %>></div>--%>
                    <div class="prodItemImg" <%# GetFileName(Eval("ImageFileName")) %>>
                        <div class="buy-now-hover" style="width: 100%; height: 100%">
                            <a class="w3-button w3-black" href='<%# Eval("Id" , "/ProductDetail.aspx?id={0}")%>'>Buy now <i class="fa fa-shopping-cart"></i>
                            </a>
                        </div>
                    </div>

                    <%--<div class="w3-display-middle w3-display-hover">
                        <a class="w3-button w3-black" href='<%# Eval("ID" , "/ProductDetail.aspx?id={0}")%>'>Buy now <i class="fa fa-shopping-cart"></i>
                        </a>
                    </div>--%>

                    <p>
                        <%# Eval("Name") %><br>
                        <b>$<%# Eval("Price") %></b>
                    </p>
                </div>

            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>

        </asp:Repeater>

        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" SelectMethod="GetAllProd" TypeName="ProdUtility"></asp:ObjectDataSource>
        <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:MyDBConnectionString1 %>' SelectCommand="SELECT * FROM [Products]"></asp:SqlDataSource>--%>
    </div>
</asp:Content>


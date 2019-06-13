<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e) {
        if (Session["ShoppingCart"] != null) {
            Dictionary<int, int> shoppingCart = Session["ShoppingCart"] as Dictionary<int, int>;

            string idString = string.Join(",", shoppingCart.Keys);
            ProdUtility pu = new ProdUtility();
            List<Product> prodList = pu.GetProductsByIDs(idString);

            ShoppingCartUtility scu = new ShoppingCartUtility();
            List<ShoppingCart> sList = scu.GetShoppingCartList(shoppingCart, prodList);

            Repeater1.DataSource = sList;
            Repeater1.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <ul class="w3-ul w3-card-4">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="w3-bar">
                <span onclick="this.parentElement.style.display='none'" class="w3-bar-item w3-button w3-white w3-xlarge w3-right">×</span>
                <img src='<%# Eval("ImageFileName" , "/img/{0}") %>' class="w3-bar-item w3-circle w3-hide-small" style="width: 85px">
                <div class="w3-bar-item">
                    <span class="w3-large"><%# Eval("Name") %></span><br>
                    <span><%# Eval("Price") %>元</span>
                </div>
                <div class="w3-bar-item">
                    <span class="w3-large">數量</span><br>
                    <span><%# Eval("Count") %></span>
                </div>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>


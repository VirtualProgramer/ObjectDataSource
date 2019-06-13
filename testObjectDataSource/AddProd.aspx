<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs e) {
        string prodName = TextBox1.Text;

        ProdUtility pu = new ProdUtility();
        List<Product> pdList = pu.GetAllProd();

        int priceCheck = 0;
        if (!int.TryParse(TextBox2.Text, out int pp) || pp <= 0 || !int.TryParse(TextBox3.Text, out int pn) || pn <= 0) {
            priceCheck = 1;
        }

        if (pu.CheckProd(prodName) || prodName == "") {
            Label1.Text = ">>>名稱未填寫或此產品已存在<<<";
        } else if (priceCheck == 1) {
            Label1.Text = ">>>請輸入正確的價格和數量<<<";
        } else {
            pu.IsertProd(TextBox1.Text, TextBox2.Text, TextBox3.Text, FileUpload1);
            Label1.Text = $">>>{prodName} 已加入清單<<<";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="addForm">
        <div class="addProduct flexRowBetween">

            <div class="addProductL">

                <div class="subRow">
                    <asp:TextBox ID="TextBox1" class="addProductTextBox" placeholder=" Name" runat="server"></asp:TextBox>
                </div>
                <div class="subRow">
                    <asp:TextBox ID="TextBox2" class="addProductTextBox" placeholder=" Price" runat="server"></asp:TextBox>
                </div>
                <div class="subRow">
                    <asp:TextBox ID="TextBox3" class="addProductTextBox" placeholder=" Quantity" runat="server"></asp:TextBox>
                </div>
                <div class="subRow">
                    <asp:FileUpload class="addProductFileUpload" ID="FileUpload1" runat="server" />
                </div>
                <div class="subRow">
                    <asp:Label ID="Label1" class="addProductState" runat="server" Text="&lt;輸入產品資訊&gt;"></asp:Label>
                </div>
                <div class="addProductBtn">
                    <asp:Button ID="Button1" class="addButton" runat="server" Text="Add Product" OnClick="Button1_Click" />
                </div>
            </div>

            <div class="addProductR">
                <div class="imgUpload">
                    <img src="#" id="blah" />
                </div>
                <div class="imgPreview">
                    <p>Preview</p>
                </div>
            </div>
        </div>
    </div>

    <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" InsertMethod="IsertProd" SelectMethod="GetAllProd" TypeName="ProdUtility">
        <InsertParameters>
            <asp:Parameter Name="name" Type="String"></asp:Parameter>
            <asp:Parameter Name="price" Type="String"></asp:Parameter>
            <asp:Parameter Name="amount" Type="String"></asp:Parameter>
            <asp:Parameter Name="image" Type="Object"></asp:Parameter>
        </InsertParameters>
    </asp:ObjectDataSource>


    <script>
        $(function () {
            $(".addProductFileUpload").change(function () {
                readURL(this);
            });
        });

        function imgReady(e) {
            $('#blah').attr('src', e.target.result).ready(function () {
                $('.imgUpload').slideDown(800);
            });
        }

        function readURL(input) {

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {

                    if ($(".imgPreview").css("display") != "none") {
                        $(".imgPreview").fadeOut(600, function () {
                            imgReady(e);
                        });
                    } else {
                        $('.imgUpload').slideUp(600, function () {
                            imgReady(e);
                        });
                    }
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

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
                <br />
                <h4>Purchase Now</h4>
            </div>
        </div>

        <div class="w3-container w3-text-grey" id="jeans">
            <p>8 items</p>
        </div>

        <div class="prodListForm">
            <%-- 由AJAX生成 --%>
        </div>

    </div>
    <ul id="myUL">
    </ul>
    <script>

        function GetFileNameAJAX(obj) {
            if (obj == null) {
                return "default.png";
            } else {
                return `${obj}`;
            }
        }

        $(function () {

            $.ajax({
                type: 'POST',
                url: '/WebService.asmx/GetAllProd',
                contentType: "application/json;charset=utf-8",
                success: function (data) {

                    $(data.d).each(function (index, item) {

                        $(".prodListForm").append(
                            `<div class="w3-container prodItem">` +
                            `   <div class="prodItemImg" style="background-image:url('../img/${GetFileNameAJAX(item.ImageFileName)}')"` +
                            `   </div>` +
                            `   <div class="buy-now-hover" style="width: 100%; height: 100%">` +
                            `       <a class="w3-button w3-black" href='/ProductDetail.aspx?id=${item.Id}'>` +
                            `           Buy now <i class="fa fa-shopping-cart"></i>` +
                            `       </a>` +
                            `   </div>` +
                            `</div>` +
                            `   <p>` +
                            `      ${item.Name}<br>` +
                            `      <b>$ ${item.Price}</b>` +
                            `   </p>` +
                            `</div>`
                        );

                    });
                }
            });
        });
    </script>

</asp:Content>


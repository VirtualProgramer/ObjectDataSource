<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="w3-container">
        <input id="Text1" type="text" />
        <input id="Button1" type="button" value="查詢" />
        <hr />
        <table class="w3-table-all w3-card-4">
            <tr>
                <th>名稱</th>
                <th>價格</th>
                <th>庫存</th>
                <th>圖檔位置</th>
            </tr>
            <tbody id="myTable">
            </tbody>

        </table>
    </div>
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script>

        $(function () {

            $("#Button1").click(function () {

                var myData = { name: $("#Text1").val() };

                $("#myTable").html("");

                $.ajax({
                    type: 'POST',
                    url: '/WebService.asmx/GetProductsByName',
                    data: JSON.stringify(myData),
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        $(data.d).each(function (index, item) {

                            $("#myTable").append(
                                `<tr>` +
                                `   <td>${item.Name}</td>` +
                                `   <td>${item.Price}</td>` +
                                `   <td>${item.Amount}</td>` +
                                `   <td>${item.ImageFileName}</td>` +
                                `</tr>`
                            );
                        });
                    }
                });
            });


        });

    </script>
</asp:Content>


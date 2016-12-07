function showTablename(str) {
                showAttrname("");
                showRelatedtable("");
                if (str == "") { 
                    document.getElementById("tableHint").innerHTML = "";
                    return;
                } else {
                    if (window.XMLHttpRequest) {
                    // code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                    //document.getElementById("txtHint").innerHTML = str;
                    } else {
                        // code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    xmlhttp.onreadystatechange = function() {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                            document.getElementById("tableHint").innerHTML = xmlhttp.responseText;
                        }
                    };
                    xmlhttp.open("GET", "gettablehint.php?q="+str, true);
                    xmlhttp.send();
                }
            }



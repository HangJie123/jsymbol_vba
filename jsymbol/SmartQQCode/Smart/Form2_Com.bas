Attribute VB_Name = "Form2_Com"
Dim ID() As String
Public Function Get_QQ_Name() '�õ���ǰ��Ⱥ����UIN
On Error Resume Next
    Dim ScriptObj As Object
    vfwebqq1 = GetIniFileString("QQ", "vfwebqq", "", 500, App.path & "\Config.ini") '�õ�vfwebqq
    hash = GetIniFileString("QQ", "hash", "", 500, App.path & "\Config.ini") '�õ�hash
    p_uin = GetIniFileString("QQ", "p_uin", "", 500, App.path & "\Config.ini") '�õ�hash
    p_skey = GetIniFileString("QQ", "pskey", "", 500, App.path & "\Config.ini") '�õ�hash
    pt4_token = GetIniFileString("QQ", "pt4_token", "", 500, App.path & "\Config.ini") '�õ�hash
    ptwebqq = GetIniFileString("QQ", "ptwebqq", "", 500, App.path & "\Config.ini") '�õ�hash

    If Len(Trim(setCookies)) = 0 Then setCookies = "a:x,"
    Set WinHttp = CreateObject("WinHttp.WinHttpRequest.5.1") '����WinHttp.WinHttpRequest
    'MsgBox "�� ����"
    WinHttp.Open "POST", "http://s.web2.qq.com/api/get_group_name_list_mask2", True 'ͬ����������
    WinHttp.Option(WinHttpRequestOption_SslErrorIgnoreFlags) = &H3300 '�ǳ���Ҫ(���Դ���)
     '��������ͷ����
       
    WinHttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    WinHttp.SetRequestHeader "Cookie", "p_uin=" & p_uin & ";p_skey=" & p_skey & ";pt4_token=" & pt4_token & ";ptwebqq=" & ptwebqq
    WinHttp.SetRequestHeader "Referer", "http://s.web2.qq.com/proxy.html?v=20130916001&callback=1&id=1"
    WinHttp.SetRequestHeader "Content-Length", Len("r={""vfwebqq"":""" & vfwebqq1 & """,""hash"":""" & hash & """}")
    WinHttp.Send "r={""vfwebqq"":""" & vfwebqq1 & """,""hash"":""" & hash & """}"
    WinHttp.WaitForResponse '�ȴ�����
    'MsgBox WinHttp.Status'����״̬
    '�õ������ı�(����������)
    get_jsonqun = WinHttp.ResponseText
    Set ScriptObj = CreateObject("MSScriptControl.ScriptControl")
    ScriptObj.AllowUI = True
    ScriptObj.Language = "JavaScript"
    ScriptObj.AddCode "var data = " & get_jsonqun & ";"
'����������ʾ��һ��delist_time
    For i = 0 To 200 '��ǰ�����Ƕ��ٸ�Ⱥ��
    'Form2.Text1.Text = Form2.Text1.Text + "Ⱥ���ƣ�|" & ScriptObj.Eval("data.result.gnamelist[" & i & "].name") & "|Gid:|" & ScriptObj.Eval("data.result.gnamelist[" & i & "].gid") & vbCrLf
    Form2.MSHFlexGrid2.TextMatrix(i + 1, 1) = ScriptObj.Eval("data.result.gnamelist[" & i & "].name")
    Form2.MSHFlexGrid2.RowHeight(i + 1) = 300
    '��������
    Form2.MSHFlexGrid2.TextMatrix(i + 1, 2) = ScriptObj.Eval("data.result.gnamelist[" & i & "].gid")
    Form2.MSHFlexGrid2.TextMatrix(i + 1, 3) = ScriptObj.Eval("data.result.gnamelist[" & i & "].code")
    SetIniFileString "Group", ScriptObj.Eval("data.result.gnamelist[" & i & "].gid"), ScriptObj.Eval("data.result.gnamelist[" & i & "].name"), App.path & "\Group.ini"
    Next
End Function


Public Function Post_QQ_Message(ByVal XmlHttpMode$, ByVal XmlHttpURL$, ByVal XmlHttpData$)
    Dim MyXmlhttp
    '�õ����ֲ������˴�һ��ҪС��
    vfwebqq1 = GetIniFileString("QQ", "vfwebqq", "", 500, App.path & "\Config.ini") '�õ�vfwebqq
    hash = GetIniFileString("QQ", "hash", "", 500, App.path & "\Config.ini") '�õ�hash
    p_uin = GetIniFileString("QQ", "p_uin", "", 500, App.path & "\Config.ini") '�õ�hash
    p_skey = GetIniFileString("QQ", "pskey", "", 500, App.path & "\Config.ini") '�õ�hash
    pt4_token = GetIniFileString("QQ", "pt4_token", "", 500, App.path & "\Config.ini") '�õ�hash
    ptwebqq = GetIniFileString("QQ", "ptwebqq", "", 500, App.path & "\Config.ini") '�õ�hash
    sKey = GetIniFileString("QQ", "skey", "", 500, App.path & "\Config.ini") '�õ�hash
    On Error GoTo wrong
    Set MyXmlhttp = CreateObject("WinHttp.WinHttpRequest.5.1")                  '����WinHttpRequest����
    With MyXmlhttp
        .setTimeouts 50000, 50000, 50000, 50000                                 '���ó�ʱʱ��
        If XmlHttpMode = "GET" Then                                             '�첽GET����
            .Open "GET", XmlHttpURL, True
        Else
            .Open "POST", XmlHttpURL, True                                      '�첽POST����
            .SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
        End If
        .SetRequestHeader "Cookie", "uin=" & p_uin & ";skey=" & sKey & ";p_uin=" & p_uin & ";p_skey=" & p_skey & ";pt4_token=" & pt4_token & ";ptwebqq=" & ptwebqq
        .SetRequestHeader "referer", "https://d1.web2.qq.com/cfproxy.html?v=20151105001&callback=1"

        .Send (XmlHttpData)
        .WaitForResponse                                                        '�첽�ȴ�
        If MyXmlhttp.Status = 200 Then                                          '�ɹ���ȡҳ��
            Post_QQ_Message = StrConv(.ResponseBody, vbUnicode)
        Else
            MsgBox "Http�������:" & .Status, vbInformation, "��ʾ"
        End If
    End With
    Set MyXmlhttp = Nothing
    Exit Function
wrong:
    MsgBox "����ԭ��:" & Err.Description & "", vbInformation, "��ʾ"
    Set MyXmlhttp = Nothing
End Function

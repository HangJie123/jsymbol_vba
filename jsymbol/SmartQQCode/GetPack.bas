Attribute VB_Name = "GetPack"
Public Function ReadinteFile(ByVal sUrl As String) As String  '�˴��ǵõ�һ�ε�½��Ϣ��Դ��
Dim xmlHTTP1 As Object
Set xmlHTTP1 = CreateObject("Microsoft.XMLHTTP")
xmlHTTP1.Open "get", sUrl, True
xmlHTTP1.Send
While xmlHTTP1.ReadyState <> 4
DoEvents
Wend
ReadinteFile = xmlHTTP1.ResponseText
Set xmlHTTP1 = Nothing
End Function


Public Function Getsky(ByVal XmlHttpData$) '�˴���д���ε�½�Ĳ���
On Error Resume Next
Dim strData As String
    If Len(Trim(setCookies)) = 0 Then setCookies = ""
    Set WinHttp = CreateObject("WinHttp.WinHttpRequest.5.1") '����WinHttp.WinHttpRequest
    'MsgBox "�� ����"
    WinHttp.setTimeouts 50000, 50000, 50000, 50000
    WinHttp.Open "GET", XmlHttpData, True 'ͬ����������
    WinHttp.Option(6) = False
     '��������ͷ����
    WinHttp.SetRequestHeader "Connection", "Close"
    WinHttp.SetRequestHeader "Content-Type", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
    WinHttp.Send
    WinHttp.WaitForResponse '�ȴ�����
    'MsgBox
    WinHttp.Status '����״̬
    '�õ������ı�(����������)
headers = WinHttp.getAllResponseHeaders
'��ȡPsky
strData = Split(Split(headers, "p_skey=")(1), ";")(0)
SetIniFileString "QQ", "pskey", strData, App.path & "\Config.ini"
strData = Split(Split(headers, "uin=")(1), ";")(0)
SetIniFileString "QQ", "uin", strData, App.path & "\Config.ini"
strData = Split(Split(headers, "skey=")(1), ";")(0)
SetIniFileString "QQ", "skey", strData, App.path & "\Config.ini"
strData = Split(Split(headers, "p_uin=")(1), ";")(0)
SetIniFileString "QQ", "p_uin", strData, App.path & "\Config.ini"
strData = Split(Split(headers, "pt4_token=")(1), ";")(0)
SetIniFileString "QQ", "pt4_token", strData, App.path & "\Config.ini"
Form1.Label2.Caption = "������д����ϡ�"
End Function

Public Function Get_vfwebqq(ByVal url$)
ptwebqq = GetIniFileString("QQ", "ptwebqq", "", 500, App.path & "\Config.ini") '�õ�ptqrtoken
pskey = GetIniFileString("QQ", "pskey", "", 500, App.path & "\Config.ini") '�õ�pskey
pt4_token = GetIniFileString("QQ", "pt4_token", "", 500, App.path & "\Config.ini") '�õ�pskey
p_uin = GetIniFileString("QQ", "p_uin", "", 500, App.path & "\Config.ini") '�õ�pskey
sKey = GetIniFileString("QQ", "skey", "", 500, App.path & "\Config.ini") '�õ�pskey
uin = GetIniFileString("QQ", "uin", "", 500, App.path & "\Config.ini") '�õ�uin
Set request = CreateObject("WinHttp.WinHttpRequest.5.1") '���ݶ���ǩ����������
request.setTimeouts 50000, 50000, 50000, 50000
request.Option(4) = 13056
request.Option(6) = False
request.Open "GET", url, True, "", ""
request.SetRequestHeader "Referer", "http://s.web2.qq.com/proxy.html?v=20" '�������Ҫ������·����Ȼ�����
request.SetRequestHeader "Cookie", "uin=" & uin & "; skey=" & sKey & "; p_uin=" & p_uin & "; p_skey=" & pskey & "; pt4_token=" & pt4_token & "; ptwebqq=" & ptwebqq '���������COOKIE����Ȼ�ò�����Ϣ
request.Send
request.WaitForResponse
If request.Status = 200 Then
strvfwebqq (request.ResponseText)
Label2.Caption = "���ڵõ�vfwebqq����"
End If
End Function

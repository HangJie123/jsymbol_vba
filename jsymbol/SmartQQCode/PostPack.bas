Attribute VB_Name = "PostPack"
Public Function Postlogin(ByVal url$, ByVal neirong)
ptwebqq = GetIniFileString("QQ", "ptwebqq", "", 500, App.path & "\Config.ini") '�õ�ptqrtoken
pskey = GetIniFileString("QQ", "pskey", "", 500, App.path & "\Config.ini") '�õ�pskey
pt4_token = GetIniFileString("QQ", "pt4_token", "", 500, App.path & "\Config.ini") '�õ�pskey
p_uin = GetIniFileString("QQ", "p_uin", "", 500, App.path & "\Config.ini") '�õ�pskey
sKey = GetIniFileString("QQ", "skey", "", 500, App.path & "\Config.ini") '�õ�pskey
uin = GetIniFileString("QQ", "uin", "", 500, App.path & "\Config.ini") '�õ�uin
Set request = CreateObject("WinHttp.WinHttpRequest.5.1") '���ݶ���ǩ����������
request.setTimeouts 50000, 50000, 50000, 50000
request.Option(4) = 13056

request.Open "POST", url, True, "", ""
request.SetRequestHeader "Referer", "http://d1.web2.qq.com/proxy.html?v=20151105001&callback=1&id=2" '�������Ҫ������·����Ȼ�����
request.SetRequestHeader "Cookie", "uin=" & uin & "; skey=" & sKey & "; p_uin=" & p_uin & "; p_skey=" & pskey & "; pt4_token=" & pt4_token & "; ptwebqq=" & ptwebqq '���������COOKIE����Ȼ�ò�����Ϣ
request.Send (neirong)
request.WaitForResponse
If request.Status = 200 Then
Strjiexi (request.ResponseText)
Label2.Caption = "���ڳ��Զ��ε�½"
End If
End Function

Public Function Post_info() As String '�˺����ǵõ�Ⱥ���еĺ���
    vfwebqq1 = GetIniFileString("QQ", "vfwebqq", "", 500, App.path & "\Config.ini") '�õ�vfwebqq
    hash = GetIniFileString("QQ", "hash", "", 500, App.path & "\Config.ini") '�õ�hash
    p_uin = GetIniFileString("QQ", "p_uin", "", 500, App.path & "\Config.ini") '�õ�hash
    p_skey = GetIniFileString("QQ", "pskey", "", 500, App.path & "\Config.ini") '�õ�hash
    pt4_token = GetIniFileString("QQ", "pt4_token", "", 500, App.path & "\Config.ini") '�õ�hash
    ptwebqq = GetIniFileString("QQ", "ptwebqq", "", 500, App.path & "\Config.ini") '�õ�hash
    If Len(Trim(setCookies)) = 0 Then setCookies = "a:x,"
    Set WinHttp = CreateObject("WinHttp.WinHttpRequest.5.1") '����WinHttp.WinHttpRequest
    'MsgBox "�� ����"
    WinHttp.Open "POST", "http://s.web2.qq.com/api/get_user_friends2", True 'ͬ����������
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
     Form1.Text3.Text = WinHttp.ResponseText '����JSON ���������
       Label2.Caption = "�û���Ϣ�ѵõ�"
End Function


Attribute VB_Name = "ģ��2"
'Author��Jingwen Long
'Example��������վ�ܱ�ԭʼ���ݣ�2017��

Sub InsertColumnBetweenFourthAndFifth()
    Dim ws As Worksheet
    
    ' ����ÿ��������
    For Each ws In ThisWorkbook.Worksheets
        ' �ڵ����е�λ�ò���һ�У���Ὣ������ԭ�������������ƶ���
        ws.Columns(5).Insert Shift:=xlToRight
    Next ws
    
    MsgBox "����ÿ��������ĵ��ĺ͵�����֮�������һ�С�"
End Sub
Sub DeleteBlankRowsInAllSheets()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long

    ' ����ÿ��������
    For Each ws In ThisWorkbook.Worksheets
        ' �ҵ���ǰ����������һ��
        lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
        
        ' �����һ�����ϱ������Ա���ɾ����ʱ���µ��кű仯����
        For i = lastRow To 1 Step -1
            ' ��鵱ǰ���Ƿ�Ϊ�հ�
            If Application.WorksheetFunction.CountA(ws.Rows(i)) = 0 Then
                ws.Rows(i).Delete
            End If
        Next i
    Next ws
    
    MsgBox "���й������еĿհ�����ɾ����"
End Sub

Sub UnmergeRowsInAllSheets()
    Dim ws As Worksheet
    Dim rng As Range

    ' �������й�����
    For Each ws In ThisWorkbook.Worksheets
        ' ȡ���ϲ���һ�к͵ڶ��еĵ�Ԫ��
        For Each rng In ws.Rows("1:2").Cells
            If rng.MergeCells Then
                rng.UnMerge
            End If
        Next rng
    Next ws
End Sub

Sub ClearFirstAndSecondRow()
    Dim ws As Worksheet
    Dim lastCol As Integer
    Dim i As Integer
    
    ' ������ǰ�����������й�����
    For Each ws In ThisWorkbook.Worksheets
        ' ���Խ����������������У�
        On Error Resume Next
        ws.Unprotect
        On Error GoTo 0
        
        ' ��ȡ����������һ��
        lastCol = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column
        
        ' ��յ�һ�к͵ڶ��е�����
        For i = 1 To lastCol
            ' �����һ�еĺϲ���Ԫ�����
            If ws.Cells(1, i).MergeCells Then
                ws.Cells(1, i).mergeArea.ClearContents  ' ��պϲ�����
            Else
                ws.Cells(1, i).ClearContents  ' ��յ�һ������
            End If
            
            ' ����ڶ��еĺϲ���Ԫ�����
            If ws.Cells(2, i).MergeCells Then
                ws.Cells(2, i).mergeArea.ClearContents  ' ��պϲ�����
            Else
                ws.Cells(2, i).ClearContents  ' ��յڶ�������
            End If
            
            ' ��������ڶ��еĸ�ʽ�����ʧ�ܣ������õ�Ԫ��
            On Error Resume Next
            ws.Cells(2, i).ClearFormats  ' �����Ԫ���ʽ
            On Error GoTo 0  ' �ָ�������ʾ
        Next i
        
        ' ���±�����������ѡ��
        ' ws.Protect
    Next ws
    
    MsgBox "���й�����ĵ�һ�к͵ڶ����ѳɹ���գ�"
End Sub

Sub ReplaceFirstAndSecondRow()
    Dim ws As Worksheet
   
    Dim newHeader2 As Variant
    Dim i As Integer
    
    ' �����±�ͷ���ݣ������޸Ĵ�����Ϊ����Ҫ��������

    newHeader2 = Array("���", "���", "�ܶ�", "ˮϵ", "��������", "��λ����", "�������", "pH", "DO", "COD", "NH3-N", "����ˮ����Ⱦ", "����ˮ����Ⱦ", "��Ҫ��Ⱦָ��") ' �ڶ�������
    
    ' ������ǰ�����������й�����
    For Each ws In ThisWorkbook.Worksheets

        ' �滻�ڶ��е�����
        For i = LBound(newHeader2) To UBound(newHeader2)
            ws.Cells(2, i + 1).Value = newHeader2(i)
        Next i
    Next ws
    MsgBox "���й�����ĵ�һ�к͵ڶ����ѳɹ�������"
End Sub

Sub DeleteFirstRowInAllSheets()
    Dim ws As Worksheet
    
    ' ����ÿ��������
    For Each ws In ThisWorkbook.Worksheets
        ' ɾ����һ��
        ws.Rows(1).Delete
    Next ws
    
    MsgBox "���й�����ĵ�һ����ɾ����"
End Sub

Sub UnmergeAndFillAllWorksheets()
    Dim ws As Worksheet
    Dim cell As Range
    Dim mergeArea As Range
    Dim valueToFill As String
    
    ' ����ÿ��������
    For Each ws In ThisWorkbook.Worksheets
        ' ���ҵ�ǰ�������е����кϲ�����
        For Each cell In ws.UsedRange
            If cell.MergeCells Then
                Set mergeArea = cell.mergeArea
                valueToFill = cell.Value
                cell.UnMerge ' ȡ���ϲ���Ԫ��
                ' ���ϲ������ֵ��䵽������ص�Ԫ��
                If Not IsEmpty(valueToFill) Then
                    mergeArea.Cells.Value = valueToFill
                End If
            End If
        Next cell
    Next ws
    
    MsgBox "���й������еĺϲ���Ԫ����ȡ�����������ֵ��"
End Sub


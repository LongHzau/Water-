Attribute VB_Name = "模块2"
'Author：Jingwen Long
'Example：历年监测站周报原始数据：2017年

Sub InsertColumnBetweenFourthAndFifth()
    Dim ws As Worksheet
    
    ' 遍历每个工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 在第五列的位置插入一列（这会将第五列原来的内容向右移动）
        ws.Columns(5).Insert Shift:=xlToRight
    Next ws
    
    MsgBox "已在每个工作表的第四和第五列之间插入了一列。"
End Sub
Sub DeleteBlankRowsInAllSheets()
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long

    ' 遍历每个工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 找到当前工作表的最后一行
        lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
        
        ' 从最后一行往上遍历，以避免删除行时导致的行号变化问题
        For i = lastRow To 1 Step -1
            ' 检查当前行是否为空白
            If Application.WorksheetFunction.CountA(ws.Rows(i)) = 0 Then
                ws.Rows(i).Delete
            End If
        Next i
    Next ws
    
    MsgBox "所有工作表中的空白行已删除。"
End Sub

Sub UnmergeRowsInAllSheets()
    Dim ws As Worksheet
    Dim rng As Range

    ' 遍历所有工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 取消合并第一行和第二行的单元格
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
    
    ' 遍历当前工作簿的所有工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 尝试解除工作表保护（如果有）
        On Error Resume Next
        ws.Unprotect
        On Error GoTo 0
        
        ' 获取工作表的最后一列
        lastCol = ws.Cells(1, ws.Columns.Count).End(xlToLeft).Column
        
        ' 清空第一行和第二行的内容
        For i = 1 To lastCol
            ' 处理第一行的合并单元格情况
            If ws.Cells(1, i).MergeCells Then
                ws.Cells(1, i).mergeArea.ClearContents  ' 清空合并区域
            Else
                ws.Cells(1, i).ClearContents  ' 清空第一行内容
            End If
            
            ' 处理第二行的合并单元格情况
            If ws.Cells(2, i).MergeCells Then
                ws.Cells(2, i).mergeArea.ClearContents  ' 清空合并区域
            Else
                ws.Cells(2, i).ClearContents  ' 清空第二行内容
            End If
            
            ' 尝试清除第二行的格式，如果失败，跳过该单元格
            On Error Resume Next
            ws.Cells(2, i).ClearFormats  ' 清除单元格格式
            On Error GoTo 0  ' 恢复错误提示
        Next i
        
        ' 重新保护工作表（可选）
        ' ws.Protect
    Next ws
    
    MsgBox "所有工作表的第一行和第二行已成功清空！"
End Sub

Sub ReplaceFirstAndSecondRow()
    Dim ws As Worksheet
   
    Dim newHeader2 As Variant
    Dim i As Integer
    
    ' 设置新表头内容，可以修改此数组为你想要的新内容

    newHeader2 = Array("序号", "年份", "周度", "水系", "河流名称", "点位名称", "断面情况", "pH", "DO", "COD", "NH3-N", "本周水质污染", "上周水质污染", "主要污染指标") ' 第二行内容
    
    ' 遍历当前工作簿的所有工作表
    For Each ws In ThisWorkbook.Worksheets

        ' 替换第二行的内容
        For i = LBound(newHeader2) To UBound(newHeader2)
            ws.Cells(2, i + 1).Value = newHeader2(i)
        Next i
    Next ws
    MsgBox "所有工作表的第一行和第二行已成功更换！"
End Sub

Sub DeleteFirstRowInAllSheets()
    Dim ws As Worksheet
    
    ' 遍历每个工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 删除第一行
        ws.Rows(1).Delete
    Next ws
    
    MsgBox "所有工作表的第一行已删除。"
End Sub

Sub UnmergeAndFillAllWorksheets()
    Dim ws As Worksheet
    Dim cell As Range
    Dim mergeArea As Range
    Dim valueToFill As String
    
    ' 遍历每个工作表
    For Each ws In ThisWorkbook.Worksheets
        ' 查找当前工作表中的所有合并区域
        For Each cell In ws.UsedRange
            If cell.MergeCells Then
                Set mergeArea = cell.mergeArea
                valueToFill = cell.Value
                cell.UnMerge ' 取消合并单元格
                ' 将合并区域的值填充到所有相关单元格
                If Not IsEmpty(valueToFill) Then
                    mergeArea.Cells.Value = valueToFill
                End If
            End If
        Next cell
    Next ws
    
    MsgBox "所有工作表中的合并单元格已取消，并已填充值。"
End Sub


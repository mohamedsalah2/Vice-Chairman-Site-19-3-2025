SELECT ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, YEAR(DDate) AS Expr1, MONTH(DDate) AS Expr2, Subject_ID, Work_area 
FROM Inventory 
WHERE (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) OR
 (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Subject_Status LIKE @Subject_Status) OR
 (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Work_area = @Work_area) OR
 (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Work_area = @Work_area) AND (Authority = @Work_area) OR
 (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Incoming_From = @Work_area) 
 ORDER BY DDate
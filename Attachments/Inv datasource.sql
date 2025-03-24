SELECT ID, Subject_ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, Attach1, Followup3, Work_area 
FROM Inventory 
WHERE (DDate = @DDATE) AND (Work_area = @Work_area) OR
 (DDate = @DDATE) AND (Authority = @Work_area) OR
 (DDate = @DDATE) AND (Incoming_From = @Work_area) OR
 (DDate = @DDATE) AND (Response_emp = @Response_emp) 
 ORDER BY ID DESC
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   A : Array(0 .. 9) of Integer := (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   I : Integer := 0;
begin
   loop
      Put(A(I));
      I := I + 1;
      exit when I = 10;
   end loop;
end Main;


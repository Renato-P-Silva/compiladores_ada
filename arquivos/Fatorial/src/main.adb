with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   function Fatorial(A : Integer) return Integer is
   begin
      if A = 0 or A = 1 then
           return 1;
      end if;
      return A * Fatorial(A - 1);
   end Fatorial;
begin
   declare
      A : Integer;
   begin
      Put("Insira um numero: ");
      Get(A);
      Put_Line("Fatorial de "&Integer'Image(A)&": "&Integer'Image(Fatorial(A)));
   end;

end Main;


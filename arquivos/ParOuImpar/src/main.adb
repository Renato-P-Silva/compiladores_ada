with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   function EhPar(A : Integer) return Boolean is
   begin
      return A mod 2 = 0;
   end EhPar;
begin
   declare
      A : Integer;
      begin
      Put("Insira um numero: ");
      Get(A);
      if EhPar(A) then
         Put_Line("Eh par.");
      else
         Put_Line("Eh impar.");
      end if;
   end;

end Main;


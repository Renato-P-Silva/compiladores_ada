with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   function Soma (A : Integer; B : Integer) return Integer is
   begin
      return A + B;
   end Soma;

begin
   declare
      A : Integer;
      B : Integer;
   begin
      Put_Line("Enter first number: ");
      Get(A);
      Put_Line("Enter second number: ");
      Get(B);
      Put_Line("A soma eh: " & Integer'Image(Soma(A, B)));
      end;

end Main;

with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;

procedure Main is
   A : Integer := 50;
   B : Float := 50.0;
   C : Float := Float(A) + B;
   D : Float := Float(A) * B;
   E : Float := Float(A + 1) / (B + 1.0);
   F : Float := Float(A) - B;
   G : Integer := A mod Integer(B);
   H : Float;
   I : Integer;
   Arr : Array(0 .. 6) of Float := (Float(A), B, C, D, E, F, Float(G));

   function Sum(A : Float; B : Float) return Float is
   begin
      return A + B;
   end Sum;


begin
   if Float(A) >= D and not (B < D and A = 0) then
      H := 30.0 * D;
   elsif (1 <= G or F /= 0.0) and E > C then
      H := F;
   else
      H := 0.0;
   end if;

   I := 0;
   loop
      if I mod 2 = 0 then
         Ada.Integer_Text_IO.Put(Integer(Arr(I)));
      end if;
      I := I + 1;
      exit when I = 7;
   end loop;
   Ada.Text_IO.New_Line;
   declare
      First : Float;
      Second : Float;
      Result : Float;
   begin
      Ada.Float_Text_IO.Get(First);
      Ada.Float_Text_IO.Get(Second);
      Result := Sum(First, Second);
      Ada.Float_Text_IO.Put(Result);
   end;

end Main;


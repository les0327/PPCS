generic
   Size : Positive;
package Data is

   --Type declaration
   type Vector is private;
   type Matrix is private;


   --Procedure declaration
   procedure Num_Vector(A: in out Vector);
   procedure Vector_Output(v : in  Vector);
   procedure Fill_Vector_With_Num(v : in out Vector; num : in Integer);
   procedure Fill_Matrix_With_Num(m : in out Matrix; num : in Integer);
   function Vector_Min(A : in Vector; from, to: in Integer) return Integer;
   function Min_Num(a1, a2 : in Integer) return Integer;

   procedure Copy(A: in out Vector; B : in Vector; from, to : in Integer);

   procedure F(A : out Vector; min:in Integer; T: in Vector; d : in Integer; S : in Vector; MO, MH: in Matrix; from, to: in Integer);

   --Type determination
   private
   type Vector is array(1..Size) of Integer;
   type Matrix is array(1..Size, 1..Size) of Integer;

end Data;

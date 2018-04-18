generic
   Size : Positive;
package Data is

   --Type declaration
   type Vector is private;
   type Matrix is private;


   --Procedure declaration
   procedure Vector_Output(v : in  Vector);
   procedure Fill_Vector_With_Num(v : in out Vector; num : in Integer);
   procedure Fill_Matrix_With_Num(m : in out Matrix; num : in Integer);
   function Scalar(A, B: in Vector; from, to: in Integer) return Integer;
   function Vector_Min(A : in Vector; from, to: in Integer) return Integer;

   procedure F(A : out Vector; scalar: in Integer;
        S: in Vector; min:in Integer; Z: in Vector; MO, MH: in Matrix; from, to: in Integer);

   --Type determination
   private
   type Vector is array(1..Size) of Integer;
   type Matrix is array(1..Size, 1..Size) of Integer;

end Data;

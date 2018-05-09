with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

package body Data is

  procedure Num_Vector(A: in out Vector) is
  begin
      A(1) := -1;
  end Num_Vector;

   procedure Vector_Output(v : in  Vector) is
   begin
      Put("(");
      for i in 1..Size loop
         Put(v(i));
         Put(" ");
      end loop;
      Put(")");
      New_Line;
   end Vector_Output;

   procedure Fill_Vector_With_Num(v : in out Vector; num : in Integer) is
   begin
      for i in 1..Size loop
         v(i) := num;
      end loop;
   end Fill_Vector_With_Num;

   procedure Fill_Matrix_With_Num(m : in out Matrix; num : in Integer) is
   begin
      for i in 1..Size loop
         for j in 1..Size loop
            m(i, j) := num;
         end loop;
      end loop;
   end Fill_Matrix_With_Num;

   procedure Copy(A: in out Vector; B : in Vector; from, to : in Integer) is
   begin
     for i in from..to loop
       A(i) := B(i);
     end loop;
   end Copy;


   --Multiplication of vector and matrix
   procedure Vector_Matrix_Multiplication(A : in Vector; B: in Matrix; C : in out Vector; from , to: in Integer) is
      buf: Integer;
   begin
      for i in from..to loop
         buf := 0;
         for j in 1..Size loop
            buf := buf + A(j) * B(j, i);
         end loop;
         C(i) := buf;
      end loop;
   end Vector_Matrix_Multiplication;

   -- Multiplication of matrices
   procedure Matrix_Multiplication(A, B: in Matrix; C : in out Matrix; From, To: in Integer) is
      buf: Integer;
   begin
      for i in 1..Size loop
         for j in from..to loop
            buf := 0;
            for k in 1..Size loop
               buf := buf + A(i, k)*B(k, j);
            end loop;
            C(i, j) := Buf;
         end loop;
      end loop;
   end Matrix_Multiplication;

   function Vector_Min(A : in Vector; from, to: in Integer) return Integer is
     min: Integer;
   begin
     min:= 200000000;
     for i in from..to loop
       if (A(i) < min) then
         min:=A(i);
       end if;
     end loop;
     return min;
   end Vector_Min;

   procedure F(A : out Vector; min:in Integer; T: in Vector; d : in Integer; S : in Vector; MO, MH: in Matrix; from, to: in Integer) is
      Mbuf: Matrix;
   begin
      Matrix_Multiplication(MO, MH, MBuf, from, to);
      Vector_Matrix_Multiplication(S, MBuf, A, from, to);
      for i in from..to loop
         A(i) := T(i) * min + A(i);
      end loop;
   end F;

   function Min_Num(a1, a2 : in Integer) return Integer is
   begin
     if (a1 > a2) then
       return a2;
    else
      return a1;
    end if;
   end Min_Num;

end Data;

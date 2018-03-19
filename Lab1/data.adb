with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

package body Data is

   procedure Vector_Input (v : out Vector) is
   begin
      for i in 1..Size loop
         Get(v(i));
      end loop;
   end Vector_Input;

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

   procedure Matrix_Input (m : out Matrix) is
   begin
      for i in 1..Size loop
         for j in 1..Size loop
            Get(m(i, j));
         end loop;
      end loop;
   end Matrix_Input;

   procedure Matrix_Output(m : in  Matrix) is
   begin
      for i in 1..Size loop
         for j in 1..Size loop
            Put(m(i, j));
            Put(" ");
         end loop;
         New_Line;
      end loop;
      New_Line;
   end Matrix_Output;
   
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
   
   procedure F(A : out Vector; B, C, Z: Vector; d: in Integer; MO, MT, MH: in Matrix; from, to: in Integer) is
      Mbuf: Matrix;
      Vbuf: Vector;
   begin
      Matrix_Multiplication(MT, MH, MBuf, from, to);
      Vector_Matrix_Multiplication(C, MO, Vbuf, from, to);
      Vector_Matrix_Multiplication(Z, MBUF, A, from, to);
      for i in from..to loop
         A(i) := A(i) + (B(i) + VBuf(i)) * d;
      end loop;
   end F;

end Data;

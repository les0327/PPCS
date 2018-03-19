
 -------------------------------------
 --Parallel and distributed computing.
 --Lab 1. Ada Semafore
 --Lisovyi Volodymyr
 --IO-53
 --13.03.18
 --A = (B + C * MO) * d + Z * (MT * MH)
---------------------------------------

with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

with Data;

procedure Main is

   N    : Integer := 1000;

   package new_data is new data(Size => N);
   use new_data;

   d : Integer;
   A, B, C, Z : Vector;
   MO, MT, MH : Matrix;
   S2, S3, Skd1: Suspension_Object;

   procedure Start is

   --Specification of Task 1 for F1
   task Task1 is
      pragma Task_Name("Task 1");
      pragma Storage_Size(65535);
   end Task1;

   --Specification of Task 2 for F2
   task Task2 is
      pragma Task_Name("Task 2");
      pragma Storage_Size(65535);
   end Task2;

   task body Task1 is
      C1, Z1 : Vector;
      d1 : Integer;
      MT1 : Matrix;
   begin
      Put_Line("Task 1 start");


      --Task 1 start waiting Task 2 input"
      Suspend_Until_True(S2);

      --Task 1 wait to enter CS
      Suspend_Until_True(Skd1);
      --Task 1 start copying data
      C1 := C;
      Z1 := Z;
      d1 := d;
      MT1 := MT;
      --Task 1 finish copying data
      Set_True(Skd1);

      --Task 1 start computing
      F(A, B, C1, Z1, d1, MO, MT1, MH, 1, N/2);
      --Task 1 finish computing

      --Task 1 wait for Task 2
      Suspend_Until_True(S3);

      if (N < 7) then
	     Put("A = ");
         Vector_Output(A);
      end if;

      Put_Line("Task 1 finish");
   end Task1;

task body Task2 is
      C2, Z2 : Vector;
      d2 : Integer;
      MT2 : Matrix;
   begin
      Put_Line("Task 2 start");

      --Task 2 start input
      d := 1;
      Fill_Vector_With_Num(B, 1);
      Fill_Vector_With_Num(C, 1);
      Fill_Vector_With_Num(Z, 1);
      Fill_Matrix_With_Num(MO, 1);
      Fill_Matrix_With_Num(MT, 1);
      Fill_Matrix_With_Num(MH, 1);

      --Task 2 send signal to Task 1
      Set_True(S2);
      --Task 2 finish input about finishing entering data

      --Task 2 wait to enter CS
      Suspend_Until_True(Skd1);
      --Task 2 start copying data
      C2 := C;
      Z2 := Z;
      d2 := d;
      MT2 := MT;
      --Task 2 finish copying data
      Set_True(Skd1);

      --Task 2 start computing
      F(A, B, C2, Z2, d2, MO, MT2, MH, N/2 + 1, N);
      --Task 2 finish computing

      --Task 2 send signal to Task 1 about finishing computing
      Set_True(S3);

      Put_Line("Task 2 finish");
      end Task2;
   begin
      null;
   end Start;
begin
    Put_Line("Main start");
    Set_True(Skd1);
   	Start;
    Put_Line("Main finish");
	Get(N);
end Main;

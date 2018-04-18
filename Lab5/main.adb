with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

with Data;

procedure Main is

   N    : Integer := 1000;

   package new_data is new data(Size => N);
   use new_data;

   protected ResourceMonitor is
     procedure SetScalar(scalar: in Integer);
     procedure SetMin(min: in Integer);
     procedure SetZ(Z: in Vector);
     procedure SetMO(MO: in Integer);
     function GetScalar return Integer;
     function GetMin return Integer;
     function GetZ return Vector;
     function GetMO return Matrix;
     private
      scalar: Integer;
      min: Integer := 200000000;
      Z: Vector;
      MO: Matrix;
   end ResourceMonitor;

   protected SignalMonitor is
     procedure InputSignal;
     procedure MinScalarSignal;
     procedure CalcSignal;
     entry WaitInput;
     entry WaitMinScalar;
     entry Wait CalcSignal;
     private
      F1: Integer := 0;
      F2: Integer := 0;
      F3: Integer := 0;
     private

   end ResourceMonitor;

   task Task1 is
      pragma Storage_Size(65535);
   end Task1;

   task Task2 is
      pragma Storage_Size(65535);
   end Task2;

   task Task3 is
      pragma Storage_Size(65535);
   end Task3;

   task Task4 is
      pragma Storage_Size(65535);
   end Task4;

   task body Task1 is
    begin
      Put_Line("Task 1 start");

      Put_Line("Task 1 finish");
    end Task1;

   task body Task2 is
    begin
      Put_Line("Task 2 start");

      Put_Line("Task 2 finish");
    end Task2;

    task body Task3 is
     begin
       Put_Line("Task 3 start");

       Put_Line("Task 3 finish");
     end Task3;

     task body Task4 is
      begin
        Put_Line("Task 4 start");

        Put_Line("Task 4 finish");
      end Task4;
begin
    Put_Line("Main start");
    Put_Line("Main finish");
end Main;

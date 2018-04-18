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
     procedure SetMO(MO: in Matrix);
     function GetScalar return Integer;
     function GetMin return Integer;
     function GetZ return Vector;
     function GetMO return Matrix;
     private
      scalar_g: Integer;
      min_g: Integer := 200000000;
      Z_g: Vector;
      MO_g: Matrix;
   end ResourceMonitor;

   protected SignalMonitor is
     procedure InputSignal;
     procedure MinScalarSignal;
     procedure CalcSignal;
     entry WaitInput;
     entry WaitMinScalar;
     entry WaitCalcSignal;
     private
      F1: Integer := 0;
      F2: Integer := 0;
      F3: Integer := 0;
   end SignalMonitor;

   protected body ResourceMonitor is
      procedure SetScalar(scalar: in Integer) is
      begin
        scalar_g := scalar_g + scalar;
      end SetScalar;
      procedure SetMin(min: in Integer) is
      begin
        if (min < min_g) then
          min_g := min;
        end if;
      end SetMin;
      procedure SetZ(Z: in Vector) is
      begin
        Z_g := Z;
      end SetZ;
      procedure SetMO(MO: in Matrix) is
      begin
        MO_g := MO;
      end SetMO;
      function GetScalar return Integer is
        begin
          return scalar_g;
        end GetScalar;
      function GetMin return Integer is
        begin
          return min_g;
        end GetMin;
      function GetZ return Vector  is
        begin
          return Z_g;
        end GetZ;
      function GetMO return Matrix is
        begin
          return MO_g;
        end GetMO;
   end ResourceMonitor;

   protected body SignalMonitor is
     procedure InputSignal is
       begin
         F1 := F1 + 1;
       end InputSignal;
     procedure MinScalarSignal is
       begin
         F2 := F2 + 1;
       end MinScalarSignal;
     procedure CalcSignal is
       begin
         F3 := F3 + 1;
       end CalcSignal;
     entry WaitInput
     when F1 = 3 is
       begin
         null;
       end WaitInput;
     entry WaitMinScalar
     when F2 = 4 is
       begin
         null;
       end WaitMinScalar;
     entry WaitCalcSignal
     when F3 = 3 is
       begin
         null;
       end WaitCalcSignal;
   end SignalMonitor;

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

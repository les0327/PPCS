with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

with Data;

procedure Main is

   N    : Integer := 4;

   package new_data is new data(Size => N);
   use new_data;

   A, B, C, S, T : Vector;
   MH: Matrix;

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
      scalar_g: Integer := 0;
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
     scalar1, min1 : Integer;
     Z1: Vector;
     MO1: Matrix;
    begin
      Put_Line("Task 1 start");
      Fill_Vector_With_Num(B, 1);
      Fill_Vector_With_Num(C, 1);
      Fill_Matrix_With_Num(MH, 1);

      SignalMonitor.InputSignal;
      SignalMonitor.WaitInput;

      scalar1 := Scalar(B, C, 1, n / 4);
      ResourceMonitor.SetScalar(scalar1);
      min1 := Vector_Min(T, 1, n / 4);
      ResourceMonitor.SetMin(min1);

      SignalMonitor.MinScalarSignal;
      SignalMonitor.WaitMinScalar;
      scalar1 := ResourceMonitor.GetScalar;
      min1 := ResourceMonitor.GetMin;
      Z1 := ResourceMonitor.GetZ;
      MO1 := ResourceMonitor.GetMO;

      F(A, scalar1, S, min1, Z1, MO1, MH, 1, n/4);

      SignalMonitor.WaitCalcSignal;
      if n < 7 then
        Put("A = ");
        Vector_Output(A);
      end if;

      Put_Line("Task 1 finish");
    end Task1;

   task body Task2 is
     scalar2, min2 : Integer;
     Z2: Vector;
     MO2: Matrix;
    begin
      Put_Line("Task 2 start");

      SignalMonitor.WaitInput;

      scalar2 := Scalar(B, C, n/4 + 1, n / 2);
      ResourceMonitor.SetScalar(scalar2);
      min2 := Vector_Min(T, n/ 4 + 1, n / 2);
      ResourceMonitor.SetMin(min2);

      SignalMonitor.MinScalarSignal;
      SignalMonitor.WaitMinScalar;
      scalar2 := ResourceMonitor.GetScalar;
      min2 := ResourceMonitor.GetMin;
      Z2 := ResourceMonitor.GetZ;
      MO2 := ResourceMonitor.GetMO;

      F(A, scalar2, S, min2, Z2, MO2, MH, n/4 + 1, n/2);

      SignalMonitor.CalcSignal;

      Put_Line("Task 2 finish");
    end Task2;

    task body Task3 is
      scalar3, min3 : Integer;
      Z3: Vector;
      MO3: Matrix;
     begin
       Put_Line("Task 3 start");
       Fill_Vector_With_Num(S, 1);
       Fill_Matrix_With_Num(MO3, 1);
       ResourceMonitor.SetMO(MO3);

       SignalMonitor.InputSignal;
       SignalMonitor.WaitInput;

       scalar3 := Scalar(B, C, n / 2 + 1, 3 * n / 4);
       ResourceMonitor.SetScalar(scalar3);
       min3 := Vector_Min(T, n / 2 + 1, 3 * n / 4);
       ResourceMonitor.SetMin(min3);

       SignalMonitor.MinScalarSignal;
       SignalMonitor.WaitMinScalar;
       scalar3 := ResourceMonitor.GetScalar;
       min3 := ResourceMonitor.GetMin;
       Z3 := ResourceMonitor.GetZ;
       MO3 := ResourceMonitor.GetMO;

       F(A, scalar3, S, min3, Z3, MO3, MH, n/2 + 1, 3*n/4);

       SignalMonitor.CalcSignal;

       Put_Line("Task 3 finish");
     end Task3;

     task body Task4 is
       scalar4, min4 : Integer;
       Z4: Vector;
       MO4: Matrix;
      begin
        Put_Line("Task 4 start");
        Fill_Vector_With_Num(T, 1);
        --Num_Vector(T, -1, 2);
        Fill_Vector_With_Num(Z4, 1);
        ResourceMonitor.SetZ(Z4);

        SignalMonitor.InputSignal;
        SignalMonitor.WaitInput;

        scalar4 := Scalar(B, C, 3 * n / 4 + 1, n);
        ResourceMonitor.SetScalar(scalar4);
        min4 := Vector_Min(T, 3 * n / 4 + 1, n);
        ResourceMonitor.SetMin(min4);

        SignalMonitor.MinScalarSignal;
        SignalMonitor.WaitMinScalar;
        scalar4 := ResourceMonitor.GetScalar;
        min4 := ResourceMonitor.GetMin;
        Z4 := ResourceMonitor.GetZ;
        MO4 := ResourceMonitor.GetMO;

        F(A, scalar4, S, min4, Z4, MO4, MH, 3 * n / 4 + 1, n);

        SignalMonitor.CalcSignal;

        Put_Line("Task 4 finish");
      end Task4;
begin
    Put_Line("Main start");
    Put_Line("Main finish");
end Main;

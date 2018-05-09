with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control, System;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Synchronous_Task_Control;

with Data;

procedure Main is

   N    : Integer := 9;
   H    : Integer := N / 9;

   package new_data is new data(Size => N);
   use new_data;
--------------------------------------------------------------------------------
   task Task1 is
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
   end Task1;

   task Task2 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task2;

   task Task3 is
     entry SetA(A: in Vector);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task3;

   task Task4 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task4;

   task Task5 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task5;

   task Task6 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task6;

   task Task7 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task7;

   task Task8 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetBD(d : in Integer; B : in Vector);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task8;

   task Task9 is
     entry SetA(A: in Vector);
     entry SetMO(MO : in Matrix);
     entry SetMin(min : in Integer);
     entry SetTSMH(T: in Vector; S: in Vector; MH: in Matrix);
   end Task9;
--------------------------------------------------------------------------------
   task body Task1 is
     A1, B1, T1, S1 : Vector;
     d1 : Integer;
     min1 : Integer;
     MO1, MH1 : Matrix;
     id, from , to : Integer;
   begin
      Put_Line("Task 1 start");
      Fill_Vector_With_Num(T1, 1);
      Fill_Vector_With_Num(S1, 1);
      Fill_Matrix_With_Num(MH1, 1);

      id := 0;
      from := id * H + 1;
      to := (id + 1) * H;

      Task2.SetTSMH(T1, S1, MH1);
      Task4.SetTSMH(T1, S1, MH1);

      accept SetMO(MO : in Matrix) DO
        MO1 := MO;
      end SetMO;
      Task4.setMO(MO1);

      accept SetBD(d : in Integer; B : in Vector) DO
        B1 := B;
        d1 := d;
      end SetBD;

      min1 := Vector_Min(B1, from ,to);
      Task4.SetMin(min1);

      accept SetMin(min : in Integer) DO
        min1 := min;
      end SetMin;

      F(A1, min1, T1, d1, S1, MO1, MH1, from, to);

      Task4.setA(A1);

      Put_Line("Task 1 finish");
    end Task1;
--------------------------------------------------------------------------------
   task body Task2 is
     A2, B2, T2, S2 : Vector;
     d2 : Integer;
     min2 : Integer;
     MO2, MH2 : Matrix;
     id, from , to : Integer;
    begin
      Put_Line("Task 2 start");

      id := 1;
      from := id * H;
      to := (id + 1) * H;

      accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
        T2 := T;
        S2 := S;
        MH2 := MH;
      end SetTSMH;
      Task3.SetTSMH(T2, S2, MH2);

      accept SetMO(MO : in Matrix) DO
        MO2 := MO;
      end SetMO;
      Task1.SetMO(MO2);

      accept SetBD(d : in Integer; B : in Vector) DO
        B2 := B;
        d2 := d;
      end SetBD;

      min2 := Vector_Min(B2, from ,to);
      Task5.SetMin(min2);

      accept SetMin(min : in Integer) DO
        min2 := min;
      end SetMin;

      F(A2, min2, T2, d2, S2, MO2, MH2, from, to);

      Task5.setA(A2);

      Put_Line("Task 2 finish");
    end Task2;
--------------------------------------------------------------------------------
    task body Task3 is
      A3, B3, T3, S3 : Vector;
      d3 : Integer;
      min3 : Integer;
      MO3, MH3 : Matrix;
      id, from , to : Integer;
     begin
       Put_Line("Task 3 start");
       Fill_Matrix_With_Num(MO3, 1);

       id := 2;
       from := id * H;
       to := (id + 1) * H;

       accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
         T3 := T;
         S3 := S;
         MH3 := MH;
       end SetTSMH;
       Task6.SetTSMH(T3, S3, MH3);

       Task2.SetMO(MO3);
       Task6.SetMO(MO3);

       accept SetBD(d : in Integer; B : in Vector) DO
         B3 := B;
         d3 := d;
       end SetBD;

       min3 := Vector_Min(B3, from ,to);
       Task6.SetMin(min3);

       accept SetMin(min : in Integer) DO
         min3 := min;
       end SetMin;

       F(A3, min3, T3, d3, S3, MO3, MH3, from, to);

       Task6.setA(A3);

       Put_Line("Task 3 finish");
     end Task3;
--------------------------------------------------------------------------------
     task body Task4 is
       A4, B4, T4, S4 : Vector;
       d4 : Integer;
       min4 : Integer;
       MO4, MH4 : Matrix;
       id, from , to : Integer;
      begin
        Put_Line("Task 4 start");

        id := 3;
        from := id * H;
        to := (id + 1) * H;

        accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
          T4 := T;
          S4 := S;
          MH4 := MH;
        end SetTSMH;
        Task5.SetTSMH(T4, S4, MH4);
        Task7.SetTSMH(T4, S4, MH4);

        accept SetMO(MO : in Matrix) DO
          MO4 := MO;
        end SetMO;
          Task7.setMO(MO4);

        accept SetBD(d : in Integer; B : in Vector) DO
          B4 := B;
          d4 := d;
        end SetBD;
        Task1.SetBD(d4, B4);

        min4 := Vector_Min(B4, from ,to);
        accept SetMin(min : in Integer) DO
          min4 := Min_Num(min4, min);
        end SetMin;
        Task7.SetMin(min4);

        accept SetMin(min : in Integer) DO
          min4 := min;
        end SetMin;
        Task1.setMin(min4);
        F(A4, min4, T4, d4, S4, MO4, MH4, from, to);

        accept SetA(A: in Vector) DO
          Copy(A4, A, 1, H);
        end SetA;
        Task7.setA(A4);

        Put_Line("Task 4 finish");
      end Task4;
--------------------------------------------------------------------------------
      task body Task5 is
        A5, B5, T5, S5 : Vector;
        d5 : Integer;
        min5 : Integer;
        MO5, MH5 : Matrix;
        id, from , to : Integer;
       begin
         Put_Line("Task 5 start");
         id := 4;
         from := id * H;
         to := (id + 1) * H;

         accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
           T5 := T;
           S5 := S;
           MH5 := MH;
         end SetTSMH;
         Task8.SetTSMH(T5, S5, MH5);

          accept SetMO(MO : in Matrix) DO
             MO5 := MO;
          end SetMO;
          Task8.SetMO(MO5);

          accept SetBD(d : in Integer; B : in Vector) DO
            B5 := B;
            d5 := d;
          end SetBD;
          Task2.SetBD(d5, B5);

          min5 := Vector_Min(B5, from ,to);
          accept SetMin(min : in Integer) DO
            min5 := Min_Num(min5, min);
          end SetMin;
          Task8.SetMin(min5);

          accept SetMin(min : in Integer) DO
            min5 := min;
          end SetMin;
          Task2.setMin(min5);

          F(A5, min5, T5, d5, S5, MO5, MH5, from, to);

          accept SetA(A: in Vector) DO
            Copy(A5, A, H, 2*H);
          end SetA;
          Task8.setA(A5);

         Put_Line("Task 5 finish");
       end Task5;
--------------------------------------------------------------------------------
       task body Task6 is
         A6, B6, T6, S6 : Vector;
         d6 : Integer;
         min6 : Integer;
         MO6, MH6 : Matrix;
         id, from , to : Integer;
        begin
          Put_Line("Task 6 start");
          id := 5;
          from := id * H;
          to := (id + 1) * H;

          accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
            T6 := T;
            S6 := S;
            MH6 := MH;
          end SetTSMH;
          Task9.SetTSMH(T6, S6, MH6);

          accept SetMO(MO : in Matrix) DO
             MO6 := MO;
          end SetMO;
          Task5.SetMO(MO6);
          Task9.SetMO(MO6);

          accept SetBD(d : in Integer; B : in Vector) DO
            B6 := B;
            d6 := d;
          end SetBD;
          Task5.SetBD(d6, B6);
          Task3.SetBD(d6, B6);

          min6 := Vector_Min(B6, from ,to);
          accept SetMin(min : in Integer) DO
            min6 := Min_Num(min6, min);
          end SetMin;
          Task9.SetMin(min6);

          accept SetMin(min : in Integer) DO
            min6 := min;
          end SetMin;
          Task5.setMin(min6);
          Task3.setMin(min6);

          F(A6, min6, T6, d6, S6, MO6, MH6, from, to);

          accept SetA(A: in Vector) DO
            Copy(A6, A, 2*H, 3*H);
          end SetA;
          Task9.setA(A6);

          Put_Line("Task 6 finish");
        end Task6;
--------------------------------------------------------------------------------
        task body Task7 is
          A7, B7, T7, S7 : Vector;
          d7 : Integer;
          min7 : Integer;
          MO7, MH7 : Matrix;
          id, from , to : Integer;
         begin
           Put_Line("Task 7 start");
           id := 6;
           from := id * H;
           to := (id + 1) * H;

           accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
             T7 := T;
             S7 := S;
             MH7 := MH;
           end SetTSMH;

           accept SetMO(MO : in Matrix) DO
              MO7 := MO;
           end SetMO;

           accept SetBD(d : in Integer; B : in Vector) DO
             B7 := B;
             d7 := d;
           end SetBD;
          Task4.SetBD(d7, B7);

            min7 := Vector_Min(B7, from ,to);
            accept SetMin(min : in Integer) DO
              min7 := Min_Num(min7, min);
            end SetMin;
            Task8.setMin(min7);

            accept SetMin(min : in Integer) DO
              min7 := min;
            end SetMin;
            Task4.setMin(min7);

            F(A7, min7, T7, d7, S7, MO7, MH7, from, to);

            accept SetA(A: in Vector) DO
              Copy(A7, A, 1, H);
              Copy(A7, A, 3*H, 4*H);
            end SetA;
            Task8.setA(A7);

           Put_Line("Task 7 finish");
         end Task7;
--------------------------------------------------------------------------------
         task body Task8 is
           A8, B8, T8, S8 : Vector;
           d8 : Integer;
           min8 : Integer;
           MO8, MH8 : Matrix;
           id, from , to : Integer;
          begin
            Put_Line("Task 8 start");
            id := 7;
            from := id * H;
            to := (id + 1) * H;

            accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
              T8 := T;
              S8 := S;
              MH8 := MH;
            end SetTSMH;

            accept SetMO(MO : in Matrix) DO
               MO8 := MO;
            end SetMO;

            accept SetBD(d : in Integer; B : in Vector) DO
              B8 := B;
              d8 := d;
            end SetBD;
            Task7.SetBD(d8, B8);

              min8 := Vector_Min(B8, from ,to);
              accept SetMin(min : in Integer) DO
                min8 := Min_Num(min8, min);
              end SetMin;
              accept SetMin(min : in Integer) DO
                min8 := Min_Num(min8, min);
              end SetMin;
              Task9.setMin(min8);

              accept SetMin(min : in Integer) DO
                min8 := min;
              end SetMin;
              Task7.setMin(min8);

              F(A8, min8, T8, d8, S8, MO8, MH8, from, to);

              accept SetA(A: in Vector) DO
                Copy(A8, A, H, 2*H);
                Copy(A8, A, 4*H, 5*H);
              end SetA;
              accept SetA(A: in Vector) DO
                Copy(A8, A, 1, H);
                Copy(A8, A, 3*H, 4*H);
                Copy(A8, A, 6*H, 7*H);
              end SetA;
              Task9.setA(A8);

            Put_Line("Task 8 finish");
          end Task8;
--------------------------------------------------------------------------------
          task body Task9 is
            A9, B9,T9, S9 : Vector;
            d9 : Integer;
            min9 : Integer;
            MO9, MH9 : Matrix;
            id, from , to : Integer;
           begin
             Put_Line("Task 9 start");
             Fill_Vector_With_Num(B9, 1);
             Num_Vector(B9);
             d9 := 1;

             id := 8;
             from := id * H;
             to := (id + 1) * H;

             accept SetTSMH(T: in Vector; S: in Vector; MH: in Matrix) DO
               T9 := T;
               S9 := S;
               MH9 := MH;
             end SetTSMH;

             accept SetMO(MO : in Matrix) DO
                MO9 := MO;
             end SetMO;

             Task8.SetBD(d9, B9);
             Task6.SetBD(d9, B9);

             min9 := Vector_Min(B9, from ,to);
             accept SetMin(min : in Integer) DO
               min9 := Min_Num(min9, min);
             end SetMin;
             accept SetMin(min : in Integer) DO
               min9 := Min_Num(min9, min);
             end SetMin;

             Task8.SetMin(min9);
             Task6.setMin(min9);

             F(A9, min9, T9, d9, S9, MO9, MH9, from, to);

             accept SetA(A: in Vector) DO
               Copy(A9, A, 2*H, 3*H);
               Copy(A9, A, 5*H, 6*H);
             end SetA;
             accept SetA(A: in Vector) DO
               Copy(A9, A, 1, 2*H);
               Copy(A9, A, 3*H, 6*H);
               Copy(A9, A, 6*H, 8*H);
             end SetA;

             Put("A=");
             Vector_Output(A9);

             Put_Line("Task 9 finish");
           end Task9;
begin
  null;
end Main;

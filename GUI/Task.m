classdef Task < uint8
    enumeration
        LowLevel (0),
        DriveOuterLoopWhole (1),
        DriveOuterLoopLeft (2),
        DriveOuterLoopRight (3),
        DriveInnerLoopWhole (4),
        DriveInnerLoopLeft (5),
        DriveInnerLoopRight (6),
        DriveRandom (7),
        Park (8),
        DeadReckonPath (9),
        DeadReckonCircuit (10)
    end
end